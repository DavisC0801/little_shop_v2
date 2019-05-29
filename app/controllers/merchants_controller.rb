class MerchantsController < ApplicationController
  def index
    @merchants = User.find_merchants
  end

  def show
    @merchant = User.find(current_user.id)
    @merchant_pending_orders = Order.pending_orders(current_user)
    render file: "/public/404", status: 404 unless current_merchant?
  end
end
