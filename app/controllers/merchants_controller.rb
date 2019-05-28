class MerchantsController < ApplicationController
  def index
    @merchants = User.find_merchants
  end

  def show
    @merchant = User.find(current_user.id)
  end
end
