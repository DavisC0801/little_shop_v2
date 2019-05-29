class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.ordering_order_status
  end
end
