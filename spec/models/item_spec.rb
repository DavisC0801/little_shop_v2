require 'rails_helper'

describe Item, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:name)}
    it {should validate_uniqueness_of(:name)}
    it {should validate_presence_of(:active)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:image)}
    it {should validate_presence_of(:inventory)}
  end

  describe "Relationships" do
    it {should belong_to :user}
    it {should have_many(:order_items)}
    it {should have_many(:orders).through(:order_items)}
  end
end