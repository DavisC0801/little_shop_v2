require 'rails_helper'

describe Order, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:status)}
  end

  describe "Relationships" do
    it {should belong_to :user}
    it {should have_many(:order_items)}
    it {should have_many(:items).through(:order_items)}
  end

  describe "Instance Methods" do
    before :each do
      @user_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @user_2 = User.create!(email: "user2@gmail.com", password: "password2", role: 0, active: true, name: "User 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")

      @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @merchant_2 = User.create!(email: "merchant2@gmail.com", password: "password2", role: 2, active: true, name: "Merchant 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")

      @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 1)
      @item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 22.22, description: "description 2", image: "https://bit.ly/2LXAlJy", inventory: 2)
      @item_3 = @merchant_1.items.create!(name: "Item 3", active: true, price: 33.33, description: "description 3", image: "https://bit.ly/2LXAlJy", inventory: 3)
      @item_4 = @merchant_1.items.create!(name: "Item 4", active: true, price: 44.44, description: "description 4", image: "https://bit.ly/2LXAlJy", inventory: 4)
      @item_5 = @merchant_2.items.create!(name: "Item 5", active: true, price: 55.55, description: "description 5", image: "https://bit.ly/2LXAlJy", inventory: 5)
      @item_6 = @merchant_2.items.create!(name: "Item 6", active: true, price: 66.66, description: "description 6", image: "https://bit.ly/2LXAlJy", inventory: 6)

      @order_1 = Order.create!(user: @user_1 , status: 0)
      @order_2 = Order.create!(user: @user_1 , status: 2)
      @order_3 = Order.create!(user: @user_2 , status: 0)
      @order_4 = Order.create!(user: @user_1 , status: 1)
      @order_5 = Order.create!(user: @user_2 , status: 2)
      @order_6 = Order.create!(user: @user_2 , status: 0)

      @order_item_1 = OrderItem.create!(item: @item_1, order: @order_1, quantity: 1, price: @item_1.price)
      @order_item_2 = OrderItem.create!(item: @item_2, order: @order_1, quantity: 1, price: @item_2.price)
      @order_item_3 = OrderItem.create!(item: @item_3, order: @order_2, quantity: 2, price: @item_3.price)
      @order_item_4 = OrderItem.create!(item: @item_2, order: @order_3, quantity: 1, price: @item_2.price)
      @order_item_5 = OrderItem.create!(item: @item_4, order: @order_4, quantity: 1, price: @item_4.price)
      @order_item_6 = OrderItem.create!(item: @item_3, order: @order_5, quantity: 1, price: @item_3.price)
      @order_item_7 = OrderItem.create!(item: @item_4, order: @order_6, quantity: 2, price: @item_4.price)
      @order_item_8 = OrderItem.create!(item: @item_5, order: @order_3, quantity: 1, price: @item_5.price, fulfilled: true)
    end

    it "#total_cost" do
      expect(@order_1.total_cost).to eq(33.33)
      expect(@order_3.total_cost).to eq(77.77)
      expect(@order_6.total_cost).to eq(44.44)
    end

    it "#total_quantity" do
      expect(@order_1.total_quantity).to eq(2)
      expect(@order_3.total_quantity).to eq(2)
      expect(@order_6.total_quantity).to eq(2)
    end

    it "#restock_items" do
      expect(@order_item_8.fulfilled).to eq(true)

      @order_3.restock_items

      expect(@order_item_8.reload.fulfilled).to eq(false)
    end

    it "#cancel_order" do
      expect(@order_1.status).to eq("Packaged")

      @order_1.cancel_order

      expect(@order_1.reload.status).to eq("Cancelled")
    end

    it "#update_order_item_fulfilled_status" do
      expect(@order_item_8.fulfilled).to eq(true)

      @order_3.mark_unfulfilled(@order_item_8)

      expect(@order_item_8.reload.fulfilled).to eq(false)
    end
  end

  describe "Class Methods" do
    before :each do
      @user_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @user_2 = User.create!(email: "user2@gmail.com", password: "password2", role: 0, active: true, name: "User 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")

      @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @merchant_2 = User.create!(email: "merchant2@gmail.com", password: "password2", role: 2, active: true, name: "Merchant 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")

      @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 1)
      @item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 22.22, description: "description 2", image: "https://bit.ly/2LXAlJy", inventory: 2)
      @item_3 = @merchant_1.items.create!(name: "Item 3", active: true, price: 33.33, description: "description 3", image: "https://bit.ly/2LXAlJy", inventory: 3)
      @item_4 = @merchant_1.items.create!(name: "Item 4", active: true, price: 44.44, description: "description 4", image: "https://bit.ly/2LXAlJy", inventory: 4)
      @item_5 = @merchant_2.items.create!(name: "Item 5", active: true, price: 55.55, description: "description 5", image: "https://bit.ly/2LXAlJy", inventory: 5)
      @item_6 = @merchant_2.items.create!(name: "Item 6", active: true, price: 66.66, description: "description 6", image: "https://bit.ly/2LXAlJy", inventory: 6)

      @order_1 = Order.create!(user: @user_1 , status: 0)
      @order_2 = Order.create!(user: @user_1 , status: 2)
      @order_3 = Order.create!(user: @user_2 , status: 0)
      @order_4 = Order.create!(user: @user_1 , status: 1)
      @order_5 = Order.create!(user: @user_2 , status: 2)
      @order_6 = Order.create!(user: @user_2 , status: 0)

      @order_item_1 = OrderItem.create!(item: @item_1, order: @order_1, quantity: 1, price: @item_1.price)
      @order_item_2 = OrderItem.create!(item: @item_2, order: @order_1, quantity: 1, price: @item_2.price)
      @order_item_3 = OrderItem.create!(item: @item_3, order: @order_2, quantity: 2, price: @item_3.price)
      @order_item_4 = OrderItem.create!(item: @item_2, order: @order_3, quantity: 1, price: @item_2.price)
      @order_item_5 = OrderItem.create!(item: @item_4, order: @order_4, quantity: 1, price: @item_4.price)
      @order_item_6 = OrderItem.create!(item: @item_3, order: @order_5, quantity: 1, price: @item_3.price)
      @order_item_7 = OrderItem.create!(item: @item_4, order: @order_6, quantity: 2, price: @item_4.price)
      @order_item_8 = OrderItem.create!(item: @item_5, order: @order_3, quantity: 1, price: @item_5.price)
    end
    it ".pending_orders" do
      @orders = Order.all

      expect(@orders.pending_orders(@merchant_1)).to eq([@order_1, @order_3, @order_6])
    end
  end
end
