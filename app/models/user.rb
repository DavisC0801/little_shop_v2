class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates_presence_of :name, :role, :active, :address, :city, :state, :zip, require: true
  validates :password, :presence =>true, :confirmation =>true
  validates_inclusion_of :active, :in => [true, false]

  has_many :orders
  has_many :items

  enum role: %w(user admin merchant)

  def self.find_merchants
    self.where(role: :merchant)
  end

  def top_items(limit)
    items.joins(:orders)
          .where("orders.status = 2")
          .select("order_items.quantity, items.name")
          .order("order_items.quantity desc, items.name asc")
          .limit(limit)
  end

  def sold_percentage
    items.joins(:orders)
          .where("orders.status = 2")
          .group("items.id")
          .select("items.count as sold_count, sum(order_items.quantity)")
  end
end
