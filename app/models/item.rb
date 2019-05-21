class Item < ApplicationRecord
  validates_presence_of :name, :active, :price, :description, :image, :inventory, require: true
  validates :name, uniqueness: true, presence: true

  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items
end
