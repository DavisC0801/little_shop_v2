require 'rails_helper'

RSpec.describe 'As a admin,', type: :feature do
  describe "when I visit '/admin/users'" do
    before :each do
      @user_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @user_2 = User.create!(email: "user2@gmail.com", password: "password2", role: 0, active: true, name: "User 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")

      @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @merchant_2 = User.create!(email: "merchant2@gmail.com", password: "password2", role: 2, active: true, name: "Merchant 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")

      @admin_1 = User.create!(email: "admin1@gmail.com", password: "password1", role: 1, active: true, name: "Admin 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @admin_2 = User.create!(email: "admin2@gmail.com", password: "password2", role: 1, active: true, name: "Admin 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")

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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
    end

    it "I see all users in the system who are not merchants nor admins" do
      visit admin_users_path

      expect(page).to have_content("Name: #{@user_1.name}")
      expect(page).to have_content("Name: #{@user_2.name}")
      expect(page).to_not have_content("Name: #{@merchant_1.name}")
      expect(page).to_not have_content("Name: #{@merchant_2.name}")
      expect(page).to_not have_content("Name: #{@admin_2.name}")
    end

    it "Each user's name is a link to a show page for that user ('/admin/users/5')" do
      visit admin_users_path

      within("#users-#{@user_1.id}-info") do
        expect(page).to have_content("Name: #{@user_1.name}")
        expect(page).to have_link("#{@user_1.name}", href: admin_user_path(@user_1))
      end

      within("#users-#{@user_2.id}-info") do
        expect(page).to have_content("Name: #{@user_2.name}")
        expect(page).to have_link("#{@user_2.name}", href: admin_user_path(@user_2))
      end
    end

    it "Next to each user's name is the date they registered" do
      visit admin_users_path

      within("#users-#{@user_1.id}-info") do
        expect(page).to have_content("Member since: #{Date.strptime(@user_1.created_at.to_s)}")
      end

      within("#users-#{@user_2.id}-info") do
        expect(page).to have_content("Member since: #{Date.strptime(@user_2.created_at.to_s)}")
      end
    end

    it "Next to each user's name is a button that says 'Upgrade to Merchant'" do
      visit admin_users_path

      within("#users-#{@user_1.id}-info") do
        expect(page).to have_button("Upgrade to Merchant")
      end
    end
  end
end
