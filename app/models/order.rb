class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: %w(pending packaged shipped cancelled)

  def total_quantity
    items.count
  end

  def grand_total
    items.sum do |item|
      item.price
    end
  end

  def return_fulfilled_items
    
  end

  def make_items_unfulfilled
    order_items.each do |order_item|
      order_item.update(fulfilled: false)
    end
  end

  def cancel_order
    self.update(status: "cancelled")
  end

end
