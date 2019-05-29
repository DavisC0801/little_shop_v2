require "rails_helper"

RSpec.describe "As a merchant" do
  before :each do
    @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
  end

  describe "when I visit my items page" do
    it "has a new item button that redirects to the new item form" do
      visit dashboard_items_path

      click_button("Add new item")
      expect(current_path).to eq new_dashboard_item_path
    end

    it "shows a form I can submit item information on and will save the item if valid" do
      visit dashboard_items_path

      click_button("Add new item")

      fill_in "Name", with: "Item 1"
      fill_in "Price", with: "11.11"
      fill_in "Description", with: "description 1"
      fill_in "Inventory", with: "1"

      click_button "Create Item"

      new_item = Item.last

      expect(new_item.name).to eq("Item 1")
      expect(new_item.price).to eq(11.11)
      expect(new_item.description).to eq("description 1")
      expect(new_item.image).to eq("https://img.etimg.com/thumb/msid-64749432,width-643,imgsize-242955,resizemode-4/art-stealing-thief-thinkstockphotos-459021285.jpg")
      expect(new_item.inventory).to eq(1)

      expect(current_path).to eq dashboard_items_path
      expect(page).to have_content("#{new_item.name} has been saved.")

      within("#item-#{new_item.id}-info") do
        expect(page).to have_content("ID: #{new_item.id}")
        expect(page).to have_content("Name: #{new_item.name}")
        expect(page).to have_css("img[src='#{new_item.image}']")
        expect(page).to have_content("Price: $#{new_item.price}")
        expect(page).to have_content("Inventory: #{new_item.inventory}")
        expect(page).to have_button("Edit Item")
        expect(page).to have_button("Disable Item")
        expect(page).to have_button("Delete Item")
      end
    end
    describe "When I try to add incorrect information it redirects and provides a message" do
      it "provides an error if I do not fill in name" do
        visit new_dashboard_item_path

        fill_in "Price", with: "11.11"
        fill_in "Description", with: "description 1"
        fill_in "Inventory", with: "1"

        click_button "Create Item"

        expect(current_path).to eq(new_dashboard_item_path)
        expect(page).to have_content("Name can't be blank")
      end

      it "provides an error if I do not fill in price" do
        visit new_dashboard_item_path

        fill_in "Name", with: "Item 1"
        fill_in "Description", with: "description 1"
        fill_in "Inventory", with: "1"

        click_button "Create Item"

        expect(current_path).to eq(new_dashboard_item_path)
        expect(page).to have_content("Price can't be blank")
      end

      it "provides an error if I do not fill in description" do
        visit new_dashboard_item_path

        fill_in "Name", with: "Item 1"
        fill_in "Price", with: "11.11"
        fill_in "Inventory", with: "1"

        click_button "Create Item"

        expect(current_path).to eq(new_dashboard_item_path)
        expect(page).to have_content("Description can't be blank")
      end

      it "provides an error if I do not fill in inventory" do
        visit new_dashboard_item_path

        fill_in "Name", with: "Item 1"
        fill_in "Price", with: "11.11"
        fill_in "Description", with: "description 1"

        click_button "Create Item"

        expect(current_path).to eq(new_dashboard_item_path)
        expect(page).to have_content("Inventory can't be blank")
      end
    end
  end
end

# All fields are re-populated with my previous data
