class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
   render file: "/public/404", status: 404 unless current_user?
  end

  def create
    item = Item.find(params[:item_id])
    session[:cart] ||= Hash.new(0)
    session[:cart][:item_id.to_s] ||= 0
    session[:cart][:item_id.to_s] = session[:cart][:item_id.to_s] + 1
    quantity = session[:cart][:item_id.to_s]
    flash[:notice] = "You have #{pluralize(quantity, 'item')} in your cart."
    redirect_to items_path
  end

  def decrease
    item = Item.find(params[:id])
    cart.remove(item.id)
    session[:cart] = cart.contents
    flash[:notice] = "You removed 1 #{item.name} from your cart."
    redirect_to cart_path
  end

  def remove
    item = Item.find(params[:item_id])
    cart.remove_all(item.id)
    flash[:notice] = "You now removed all #{item.name} in your cart."
    session[:cart] = cart.contents
    redirect_to cart_path
  end

  def destroy
    cart.contents.clear
    redirect_to cart_path
    flash[:message] = 'Your cart is empty'
  end

  def checkout
    new_order = current_user.orders.create
    cart.item_and_quantity.each do |item, quantity|
      OrderItem.create(item: item, order: new_order, quantity: quantity, price_per_item: item.price)
    end
    session.delete(:cart)
    flash[:message] = "Your order was submitted"
    redirect_to user_orders_path
  end

  private

  def to_cart(item)
    if cart.count_of(item.id) + 1 <= item.inventory
      cart.add_item(item.id)
      quantity = cart.count_of(item.id)
    else
      flash[:error] = "#{item.name} is not available"
    end
  end
end
