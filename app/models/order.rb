class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum role: %w(pending packaged shipped cancelled)

  def total_cost
    order_items.sum(:price)
  end

  def self.pending_orders(current_user)
    # binding.pry
    joins(:items)
    .select("orders.id, orders.created_at, order_items.quantity")
    .where("orders.status = 0 and items.user_id = #{current_user.id}")
  end
end
