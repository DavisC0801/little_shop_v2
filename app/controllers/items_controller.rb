class ItemsController < ApplicationController
  def index
    @items = Item.all_active
  end
end
