class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: %w(Packaged Pending Shipped Cancelled)

  def total_quantity
    order_items.sum(:quantity)
  end

  def total_cost
    order_items.sum(:price)
  end

  def restock_items
    order_items.each do |order_item|
      update_inventory(order_item)
      mark_unfulfilled(order_item)
    end
  end

  def update_inventory(order_item)
    item = Item.find(order_item.item_id)
    if order_item.fulfilled == true
      item.update(inventory: (item.inventory + order_item.quantity))
    end
  end

  def mark_unfulfilled(order_item)
    order_item.update(fulfilled: false)
  end

   def cancel_order
    self.update(status: "Cancelled")
  end

  def self.pending_orders(current_user)
    joins(:items)
    .select("orders.*, order_items.quantity").distinct
    .where('orders.status' => 0, 'items.user_id' => current_user.id)
  end

  def self.sort_order_status
    order(:status)
  end
end
