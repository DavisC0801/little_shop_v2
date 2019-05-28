class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: %w(pending packaged shipped cancelled)

  def total_quantity
    items.sum(:quantity)
  end

  def total_cost
    items.sum(:price)
  end

  def restock_items
    order_items.each do |order_item|
      item = Item.find(order_item.item_id)
      if order_item.fulfilled == true
        item.update(inventory: (item.inventory + order_item.quantity))
      end
      order_item.update(fulfilled: false)
    end
  end

  def cancel_order
    self.update(status: "cancelled")
  end

end
