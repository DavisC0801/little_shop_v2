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
      item = Item.find(order_item.item_id)
      if order_item.fulfilled == true
        item.update(inventory: (item.inventory + order_item.quantity))
      end
      order_item.update(fulfilled: false)
    end
  end

   def cancel_order
    self.update(status: "Cancelled")
  end

  def self.pending_orders(current_user)
    joins(:items)
    .select("orders.*, order_items.quantity").distinct
    .where('orders.status' => 0, 'items.user_id' => current_user.id)
  end

  def self.ordering_order_status
    order("CASE
            WHEN status=0 THEN 1
            WHEN status=1 THEN 2
            WHEN status=2 THEN 3
            WHEN status=3 THEN 4
          END")
  end
end
