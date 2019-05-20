require 'rails_helper'

describe OrderItem, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:fulfilled)}
  end

  describe "Relationships" do
    it {should belong_to :item}
    it {should belong_to :order}
  end
end
