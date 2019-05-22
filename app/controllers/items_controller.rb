class ItemsController < ApplicationController
  def index
    @items = Item.all_active
  end

  def show

  end
end
