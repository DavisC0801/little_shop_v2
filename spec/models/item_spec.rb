require 'rails_helper'

describe Item, type: :model do
  before :each do
    @merchant_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "Name 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
    @merchant_2 = User.create!(email: "user2@gmail.com", password: "password2", role: 1, active: true, name: "Name 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")
    @item_1 = @merchant_1.items.create!(name: "name 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 1)
    @item_2 = @merchant_1.items.create!(name: "name 2", active: false, price: 22.22, description: "description 2", image: "https://bit.ly/2LXAlJy", inventory: 2)
    @item_3 = @merchant_2.items.create!(name: "name 3", active: true, price: 33.33, description: "description 3", image: "https://bit.ly/2LXAlJy", inventory: 3)
    @item_4 = @merchant_2.items.create!(name: "name 4", active: true, price: 44.44, description: "description 4", image: "https://bit.ly/2LXAlJy", inventory: 4)
  end

  describe "Validations" do
    it {should validate_presence_of(:name)}
    it {should validate_uniqueness_of(:name)}
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

  describe "Class Methods" do
    it ".all_active" do
      expect(Item.all_active.count).to eq(3)
    end
  end

  describe "Instance Methods" do
    it "#deactivate" do
      @item_1.deactivate

      expect(@item_1.active).to eq(false)
    end

    it "#activate" do
      @item_2.activate

      expect(@item_2.active).to eq(true)
    end
  end
end
