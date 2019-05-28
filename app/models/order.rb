class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  
  enum status: %w(pending packaged shipped cancelled)

  def total_cost
    order_items.sum(:price)
  end

  def total_quantity
    items.sum(:quantity) 
  end
  
   def cancel_order
    self.update(status: "cancelled")
  end

  def self.pending_orders(current_user)
    # binding.pry
    joins(:items)
    .select("orders.*, order_items.quantity").distinct
    .where('orders.status' => 0, 'items.user_id' => current_user.id)
  end
end
