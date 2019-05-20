class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, :role, :active, :address, :city, :state, :zip, require: true

  has_many :orders
  has_many :items
end
