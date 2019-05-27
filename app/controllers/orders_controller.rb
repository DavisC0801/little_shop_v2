class OrdersController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @order = Order.find(params[:id])
  end

  def cancel
    @order = Order.find(params[:id])
    @order.make_items_unfulfilled
    @order.cancel_order
    @order.return_fulfilled_items
    redirect_to profile_order_path(@order)
    flash[:message] = "Order #{@order.id} has been cancelled"
  end
end
