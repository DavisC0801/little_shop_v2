class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum role: %w(pending packaged shipped cancelled)


  def total_quantity
    items.count
  end

  def grand_total
    items.sum do |item|
      item.price
    end
  end
end
