require "rails_helper"

RSpec.describe "As a merchant" do
  describe "when I visit my items page 'dashboard/items'" do
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

    it "shows a link to add a new item" do
      visit dashboard_items_path

      expect(page).to have_button("Add new item")
    end

    it "shows each item added to the system" do
      visit dashboard_items_path

      within("#item-#{@item_1.id}-info") do
        expect(page).to have_content("ID: #{@item_1.id}")
        expect(page).to have_content("Name: #{@item_1.name}")
        expect(page).to have_css("img[src='#{@item_1.image}']")
        expect(page).to have_content("Price: $#{@item_1.price}")
        expect(page).to have_content("Inventory: #{@item_1.inventory}")
        expect(page).to have_button("Edit Item")
      end
      within("#item-#{@item_2.id}-info") do
        expect(page).to have_content("ID: #{@item_2.id}")
        expect(page).to have_content("Name: #{@item_2.name}")
        expect(page).to have_css("img[src='#{@item_2.image}']")
        expect(page).to have_content("Price: $#{@item_2.price}")
        expect(page).to have_content("Inventory: #{@item_2.inventory}")
        expect(page).to have_button("Edit Item")
      end
      within("#item-#{@item_3.id}-info") do
        expect(page).to have_content("ID: #{@item_3.id}")
        expect(page).to have_content("Name: #{@item_3.name}")
        expect(page).to have_css("img[src='#{@item_3.image}']")
        expect(page).to have_content("Price: $#{@item_3.price}")
        expect(page).to have_content("Inventory: #{@item_3.inventory}")
        expect(page).to have_button("Edit Item")
      end
      within("#item-#{@item_4.id}-info") do
        expect(page).to have_content("ID: #{@item_4.id}")
        expect(page).to have_content("Name: #{@item_4.name}")
        expect(page).to have_css("img[src='#{@item_4.image}']")
        expect(page).to have_content("Price: $#{@item_4.price}")
        expect(page).to have_content("Inventory: #{@item_4.inventory}")
        expect(page).to have_button("Edit Item")
      end
      within("#item-#{@item_5.id}-info") do
        expect(page).to have_content("ID: #{@item_5.id}")
        expect(page).to have_content("Name: #{@item_5.name}")
        expect(page).to have_css("img[src='#{@item_5.image}']")
        expect(page).to have_content("Price: $#{@item_5.price}")
        expect(page).to have_content("Inventory: #{@item_5.inventory}")
        expect(page).to have_button("Edit Item")
      end
    end

    it "shows a button to disable and enable items" do
      visit dashboard_items_path

      within("#item-#{@item_1.id}-info") do
        expect(page).to have_button("Disable Item")
      end
      within("#item-#{@item_2.id}-info") do
        expect(page).to have_button("Disable Item")
      end
      within("#item-#{@item_3.id}-info") do
        expect(page).to have_button("Disable Item")
      end
      within("#item-#{@item_4.id}-info") do
        expect(page).to have_button("Disable Item")
      end
      within("#item-#{@item_5.id}-info") do
        expect(page).to have_button("Enable Item")
      end
    end

    it "shows a button to delete an item if unordered" do
      visit dashboard_items_path

      within("#item-#{@item_1.id}-info") do
        expect(page).to_not have_button("Delete Item")
      end
      within("#item-#{@item_2.id}-info") do
        expect(page).to have_button("Delete Item")
      end
      within("#item-#{@item_3.id}-info") do
        expect(page).to have_button("Delete Item")
      end
      within("#item-#{@item_4.id}-info") do
        expect(page).to have_button("Delete Item")
      end
      within("#item-#{@item_5.id}-info") do
        expect(page).to have_button("Delete Item")
      end
    end
  end
end
