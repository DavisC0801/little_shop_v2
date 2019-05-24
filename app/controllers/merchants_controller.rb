class MerchantsController < ApplicationController
  def index

  end

  def show
    @merchant = User.find(current_user.id)
  end
end
