class ItemsController < ApplicationController
  def index
    @items = Item.all_active
  end

  def show
    @item = Item.find(params[:id])
  end
end
