class ItemsController < ApplicationController
  def index
    @items = Item.all_active
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    item = Item.new(item_params)
    if item.save
      flash[:message] = "#{item.name} has been saved."
      redirect_to dashboard_items_path
    else
      flash[:message] = item.errors.full_messages.first
      redirect_back(fallback_location: new_dashboard_item_path)
    end
  end

  def item_params
    item_params = params.require(:item).permit(:name, :price, :description, :image, :inventory)
    item_params[:user_id] = current_user.id
    item_params[:image] = "https://img.etimg.com/thumb/msid-64749432,width-643,imgsize-242955,resizemode-4/art-stealing-thief-thinkstockphotos-459021285.jpg" if item_params[:image] == ""
    item_params
  end
end
