require "rails_helper"

RSpec.describe "As a merchant" do
  before :each do
    @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
    @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 1)
    @item_2 = @merchant_1.items.create!(name: "Item 2", active: true, price: 22.22, description: "description 2", image: "https://bit.ly/2LXAlJy", inventory: 2)
    @item_3 = @merchant_1.items.create!(name: "Item 3", active: true, price: 33.33, description: "description 3", image: "https://bit.ly/2LXAlJy", inventory: 3)
    @item_4 = @merchant_1.items.create!(name: "Item 4", active: true, price: 44.44, description: "description 4", image: "https://bit.ly/2LXAlJy", inventory: 4)
    @item_5 = @merchant_1.items.create!(name: "Item 5", active: false, price: 55.55, description: "description 5", image: "https://bit.ly/2LXAlJy", inventory: 5)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
  end

  describe "when I visit my items page" do
    it "has a new item button that redirects to the edit item form" do
      visit dashboard_items_path

      within("#item-#{@item_1.id}-info") do
        click_button("Edit Item")
      end

      expect(current_path).to eq edit_dashboard_item_path(@item_1)
    end

    it "shows a form I can submit item information on and will save the item if valid" do
      visit dashboard_items_path

      within("#item-#{@item_1.id}-info") do
        click_button("Edit Item")
      end

      fill_in "Name", with: "Item 11"
      fill_in "Price", with: "111.111"
      fill_in "Description", with: "description 11"
      fill_in "Inventory", with: "11"

      click_button "Update Item"

      expect(@item_1.name).to eq("Item 11")
      expect(@item_1.price).to eq(111.111)
      expect(@item_1.description).to eq("description 11")
      expect(@item_1.image).to eq("https://img.etimg.com/thumb/msid-64749432,width-643,imgsize-242955,resizemode-4/art-stealing-thief-thinkstockphotos-459021285.jpg")
      expect(@item_1.inventory).to eq(11)

      expect(current_path).to eq dashboard_items_path
      expect(page).to have_content("#{@item_1.name} has been updated.")

      within("#item-#{@item_1.id}-info") do
        expect(page).to have_content("ID: #{@item_1.id}")
        expect(page).to have_content("Name: #{@item_1.name}")
        expect(page).to have_css("img[src='#{@item_1.image}']")
        expect(page).to have_content("Price: $#{@item_1.price}")
        expect(page).to have_content("Inventory: #{@item_1.inventory}")
        expect(page).to have_button("Edit Item")
        expect(page).to have_button("Disable Item")
        expect(page).to have_button("Delete Item")
      end
    end

    describe "When I try to add incorrect information it redirects and provides a message" do
      it "provides an error if I do not fill in name" do
        visit edit_dashboard_item_path(@item_1)

        fill_in "Price", with: "11.11"
        fill_in "Description", with: "description 1"
        fill_in "Inventory", with: "1"

        click_button "Update Item"

        expect(current_path).to eq(edit_dashboard_item_path(@item_1))
        expect(page).to have_content("Name can't be blank")
      end

      it "provides an error if I do not fill in price" do
        visit edit_dashboard_item_path(@item_1)

        fill_in "Name", with: "Item 1"
        fill_in "Description", with: "description 1"
        fill_in "Inventory", with: "1"

        click_button "Update Item"

        expect(current_path).to eq(edit_dashboard_item_path(@item_1))
        expect(page).to have_content("Price can't be blank")
      end

      it "provides an error if I do not fill in description" do
        visit edit_dashboard_item_path(@item_1)

        fill_in "Name", with: "Item 1"
        fill_in "Price", with: "11.11"
        fill_in "Inventory", with: "1"

        click_button "Update Item"

        expect(current_path).to eq(edit_dashboard_item_path(@item_1))
        expect(page).to have_content("Description can't be blank")
      end

      it "provides an error if I do not fill in inventory" do
        visit edit_dashboard_item_path(@item_1)

        fill_in "Name", with: "Item 1"
        fill_in "Price", with: "11.11"
        fill_in "Description", with: "description 1"

        click_button "Update Item"

        expect(current_path).to eq(edit_dashboard_item_path(@item_1))
        expect(page).to have_content("Inventory can't be blank")
      end
    end
  end
end
