require 'rails_helper'

describe User, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:role)}
    it {should validate_presence_of(:active)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
    it {should validate_confirmation_of(:password)}
  end

  describe "Relationships" do
    it {should have_many(:orders)}
    it {should have_many(:items)}
  end

  describe "Instance Methods" do
    before :each do
      @user_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @user_2 = User.create!(email: "user2@gmail.com", password: "password2", role: 0, active: true, name: "User 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")
      @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 1)
      @item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 22.22, description: "description 2", image: "https://bit.ly/2LXAlJy", inventory: 2)
      @item_3 = @merchant_1.items.create!(name: "Item 3", active: true, price: 33.33, description: "description 3", image: "https://bit.ly/2LXAlJy", inventory: 3)
      @item_4 = @merchant_1.items.create!(name: "Item 4", active: true, price: 44.44, description: "description 4", image: "https://bit.ly/2LXAlJy", inventory: 4)
      @item_5 = @merchant_1.items.create!(name: "Item 5", active: true, price: 55.55, description: "description 5", image: "https://bit.ly/2LXAlJy", inventory: 5)
      @item_6 = @merchant_1.items.create!(name: "Item 6", active: true, price: 66.66, description: "description 6", image: "https://bit.ly/2LXAlJy", inventory: 6)
      @item_7 = @merchant_1.items.create!(name: "Item 7", active: true, price: 77.77, description: "description 7", image: "https://bit.ly/2LXAlJy", inventory: 7)
      @item_8 = @merchant_1.items.create!(name: "Item 8", active: true, price: 88.88, description: "description 8", image: "https://bit.ly/2LXAlJy", inventory: 8)
      @item_9 = @merchant_1.items.create!(name: "Item 9", active: true, price: 99.99, description: "description 9", image: "https://bit.ly/2LXAlJy", inventory: 9)
      @order_1 = Order.create!(user: @user_1 , status: 0)
      @order_2 = Order.create!(user: @user_1 , status: 2)
      @order_3 = Order.create!(user: @user_2 , status: 0)
      @order_4 = Order.create!(user: @user_1 , status: 1)
      @order_5 = Order.create!(user: @user_2 , status: 2)
      @order_6 = Order.create!(user: @user_2 , status: 0)
      @order_7 = Order.create!(user: @user_1 , status: 2)
      @order_8 = Order.create!(user: @user_2 , status: 2)
      @order_item_1 = OrderItem.create!(item: @item_1, order: @order_1, quantity: 1, price: @item_1.price)
      @order_item_2 = OrderItem.create!(item: @item_2, order: @order_1, quantity: 1, price: @item_2.price)
      @order_item_3 = OrderItem.create!(item: @item_3, order: @order_2, quantity: 1, price: @item_3.price)
      @order_item_4 = OrderItem.create!(item: @item_2, order: @order_3, quantity: 1, price: @item_2.price)
      @order_item_5 = OrderItem.create!(item: @item_4, order: @order_4, quantity: 1, price: @item_4.price)
      @order_item_6 = OrderItem.create!(item: @item_4, order: @order_5, quantity: 2, price: @item_3.price)
      @order_item_7 = OrderItem.create!(item: @item_5, order: @order_6, quantity: 2, price: @item_5.price)
      @order_item_8 = OrderItem.create!(item: @item_6, order: @order_6, quantity: 2, price: @item_6.price)
      @order_item_9 = OrderItem.create!(item: @item_7, order: @order_7, quantity: 3, price: @item_7.price)
      @order_item_10 = OrderItem.create!(item: @item_8, order: @order_7, quantity: 2, price: @item_8.price)
      @order_item_11 = OrderItem.create!(item: @item_9, order: @order_8, quantity: 4, price: @item_9.price)
    end

    it "returns the top items by quantity" do
      expect(@merchant_1.top_items(1).first.name).to eq(@item_9.name)
      expect(@merchant_1.top_items(3).first.name).to eq(@item_9.name)
      expect(@merchant_1.top_items(3).second.name).to eq(@item_7.name)
      expect(@merchant_1.top_items(3).third.name).to eq(@item_4.name)
    end

    it "finds the total count and percentage of items sold" do
      expect(@merchant1.sold_percentage.sold_count).to eq(12)
      expect(@merchant1.sold_percentage.percentage).to eq(26.7)
    end
  end
end
