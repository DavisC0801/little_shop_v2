require "rails_helper"

RSpec.describe "As a merchant" do
  describe "When I visit my items page" do
    before :each do
      @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @user_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 1)
      @item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 22.22, description: "description 2", image: "https://bit.ly/2LXAlJy", inventory: 2)
      @item_3 = @merchant_1.items.create!(name: "Item 3", active: true, price: 33.33, description: "description 3", image: "https://bit.ly/2LXAlJy", inventory: 3)
      @item_4 = @merchant_1.items.create!(name: "Item 4", active: true, price: 44.44, description: "description 4", image: "https://bit.ly/2LXAlJy", inventory: 4)
      @item_5 = @merchant_1.items.create!(name: "Item 5", active: false, price: 55.55, description: "description 5", image: "https://bit.ly/2LXAlJy", inventory: 5)
      @order_1 = Order.create!(user: @user_1 , status: 0)
      @order_item_1 = OrderItem.create!(item: @item_1, order: @order_1, quantity: 1, price: @item_1.price)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    end

    it "shows a message and returns a page if I enable an item" do
      visit dashboard_items_path

      within("#item-#{@item_5.id}-info") do
        click_button("Enable Item")
      end

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("#{@item_5.name} is now avalible for sale.")
      expect(@merchant_1.items.last.active).to be true
    end

    it "shows a message and returns a page if I disable an item" do
      visit dashboard_items_path

      within("#item-#{@item_1.id}-info") do
        click_button("Disable Item")
      end

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("#{@item_1.name} is no longer avalible for sale.")
      expect(@merchant_1.items.first.active).to be false
    end
  end
end
