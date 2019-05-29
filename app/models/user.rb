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

  def self.find_users
    self.where(role: :user)
  end

  def top_items(limit)
    items.joins(:orders)
          .where("orders.status = 2")
          .select("order_items.quantity, items.name")
          .order("order_items.quantity desc, items.name asc")
          .limit(limit)
  end
end
