class OrdersController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @order = Order.find(params[:id])
  end

  def cancel
    @order = Order.find(params[:id])
    @order.restock_items
    @order.cancel_order
    redirect_to profile_order_path(@order)
    flash[:message] = "Order #{@order.id} has been cancelled"
  end
end
