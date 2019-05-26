class MerchantsController < ApplicationController
  def index

  end

  def show
    @merchant = User.find(current_user.id)
    @merchant_pending_orders = Order.pending_orders(current_user)
    # binding.pry
  end
end
