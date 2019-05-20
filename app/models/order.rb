class Order < ApplicationRecord
  validates_presence_of :status
end
