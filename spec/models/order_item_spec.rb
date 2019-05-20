require 'rails_helper'

describe OrderItem, type: :model do
  describe "validations" do
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:fulfilled)}
  end
end
