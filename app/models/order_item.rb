class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :price, :fulfilled
end
