class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :price, :fulfilled

  belongs_to :item
  belongs_to :order
end
