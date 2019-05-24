class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates_presence_of :name, :role, :active, :address, :city, :state, :zip, require: true
  validates :password, :presence =>true, :confirmation =>true
  validates_inclusion_of :active, :in => [true, false]

  has_many :orders
  has_many :items

  enum role: %w(user admin merchant)
end
