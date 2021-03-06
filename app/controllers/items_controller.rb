class ItemsController < ApplicationController

  def index
    @items = Item.all_active
    @cart = Cart.new(session[:cart])
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

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:message] = "#{item.name} has been updated."
      redirect_to dashboard_items_path
    else
      flash[:message] = item.errors.full_messages.first
      redirect_back(fallback_location: edit_dashboard_item_path(item))
    end
  end

  def item_params
    item_params = params.require(:item).permit(:name, :price, :description, :image, :inventory)
    item_params[:user_id] = current_user.id
    item_params[:image] = "https://img.etimg.com/thumb/msid-64749432,width-643,imgsize-242955,resizemode-4/art-stealing-thief-thinkstockphotos-459021285.jpg" if item_params[:image] == ""
    item_params
  end
end
