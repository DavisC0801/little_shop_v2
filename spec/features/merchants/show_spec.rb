require 'rails_helper'

RSpec.describe 'As a merchant,', type: :feature do
  describe "when I visit my /dashboard" do
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

    it "I see merchant's info" do
      visit login_path
      fill_in "Email", with: @merchant_1.email
      fill_in "Password", with: @merchant_1.password
      click_button "Log In"

      visit dashboard_path

      within("#merchant-#{@merchant_1.id}-info") do
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Name: #{@merchant_1.name}")
        expect(page).to have_content("E-Mail: #{@merchant_1.email}")
        expect(page).to have_content("Address: #{@merchant_1.address}")
        expect(page).to have_content("City: #{@merchant_1.city}")
        expect(page).to have_content("State: #{@merchant_1.state}")
        expect(page).to have_content("Zip: #{@merchant_1.zip}")
      end
    end

    describe "if any users have pending orders containing items I sell" do
      it "I see a list of these orders" do
        visit login_path
        fill_in "Email", with: @merchant_1.email
        fill_in "Password", with: @merchant_1.password
        click_button "Log In"

        visit dashboard_path

        within("#pending-orders") do
          expect(page).to have_content("Order ID: #{@order_item_1.id}")
          expect(page).to have_link("Order ID: #{@order_item_1.id}")
          expect(page).to have_content("Date Ordered: #{@order_item_1.created_at}")
          expect(page).to have_content("Quantity: #{@order_item_1.quantity}")
          expect(page).to have_content("Total Cost: #{@order_item_1.total_cost}")

          expect(page).to have_content("Order ID: #{@order_item_3.id}")
          expect(page).to have_link("Order ID: #{@order_item_3.id}")
          expect(page).to have_content("Date Ordered: #{@order_item_3.created_at}")
          expect(page).to have_content("Quantity: #{@order_item_3.quantity}")
          expect(page).to have_content("Total Cost: #{@order_item_3.total_cost}")

          expect(page).to have_content("Order ID: #{@order_item_6.id}")
          expect(page).to have_link("Order ID: #{@order_item_6.id}")
          expect(page).to have_content("Date Ordered: #{@order_item_6.created_at}")
          expect(page).to have_content("Quantity: #{@order_item_6.quantity}")
          expect(page).to have_content("Total Cost: #{@order_item_6.total_cost}")
        end
      end
    end
  end
end
