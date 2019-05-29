class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.sort_order_status
  end
end
