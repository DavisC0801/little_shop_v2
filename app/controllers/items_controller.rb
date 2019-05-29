class ItemsController < ApplicationController

  def index
    @items = Item.all
    @cart = Cart.new(session[:cart])
  end

  def show
    @item = Item.find(params[:id])
  end
end
