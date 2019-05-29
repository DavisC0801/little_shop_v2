require 'rails_helper'

describe Item, type: :model do
  before :each do
    @user= User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "Name 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
    @merchant = User.create!(email: "user2@gmail.com", password: "password2", role: 1, active: true, name: "Name 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")
    @item_1 = @merchant.items.create!(name: "name 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 2)
    @item_2 = @merchant.items.create!(name: "name 2", active: false, price: 22.22, description: "description 2", image: "https://bit.ly/2LXAlJy", inventory: 2)
    @item_3 = @merchant.items.create!(name: "name 3", active: true, price: 33.33, description: "description 3", image: "https://bit.ly/2LXAlJy", inventory: 2)
    @item_4 = @merchant.items.create!(name: "name 4", active: true, price: 33.33, description: "description 3", image: "https://bit.ly/2LXAlJy", inventory: 2)
    @order_1 = @user.orders.create!
    @order_2 = @user.orders.create!
    @order_item_1 = OrderItem.create!(order_id: @order_1.id, item_id: @item_1.id, quantity: 2, price: 11.11)
    @order_item_2 = OrderItem.create!(order_id: @order_1.id, item_id: @item_2.id, quantity: 2, price: 22.22)
    @order_item_3 = OrderItem.create!(order_id: @order_2.id, item_id: @item_2.id, quantity: 2, price: 22.22)
    @order_item_4 = OrderItem.create!(order_id: @order_2.id, item_id: @item_3.id, quantity: 2, price: 33.33)
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

    it "#ordered?" do
      expect(@item_4.ordered?).to eq(false)
    end

    it "#subtotal" do
      expect(@item_1.subtotal(@order_1)).to eq(22.22)
    end

    it "#order_quantity" do
      expect(@item_1.order_quantity(@order_1)).to eq(2)
    end
  end
end
