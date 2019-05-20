class Item < ApplicationRecord
  validates_presence_of :name, :active, :price, :description, :image, :inventory
end
