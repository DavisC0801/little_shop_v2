class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, :role, :active, :address, :city, :state, :zip, require: true
  validates_numericality_of :role, only_integer: true

  has_many :orders
  has_many :items
end
