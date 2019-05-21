class OrderItem < ApplicationRecord
  validates_presence_of :quantity, :price, :fulfilled, require: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10000}
  validates_inclusion_of :fulfilled, :in => [true, false]

  belongs_to :item
  belongs_to :order
end
