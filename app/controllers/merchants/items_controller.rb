class Merchants::ItemsController < Merchants::BaseController
  def index
    @merchant = User.find(current_user.id)
  end
end
