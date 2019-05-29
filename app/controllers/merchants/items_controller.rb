class Merchants::ItemsController < Merchants::BaseController
  def index
    @merchant = User.find(current_user.id)
  end

  def activate
    item = Item.find(params[:item_id])
    item.activate
    flash[:message] = "#{item.name} is now avalible for sale."
    redirect_to dashboard_items_path
  end

  def deactivate
    item = Item.find(params[:item_id])
    item.deactivate
    flash[:message] = "#{item.name} is no longer avalible for sale."
    redirect_to dashboard_items_path
  end

  def destroy
    item = Item.find(params[:id])
    item.delete
    flash[:message] = "#{item.name} has been deleted."
    redirect_to dashboard_items_path
  end

  def edit

  end

  def new
    @item = Item.new
  end
end
