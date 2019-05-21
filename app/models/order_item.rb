class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :price, :fulfilled
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10000}
  
  belongs_to :item
  belongs_to :order
end
