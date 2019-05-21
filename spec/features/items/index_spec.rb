require 'rails_helper'

RSpec.describe 'As any kind of user,', type: :feature do
  describe "I can visit '/items'" do
    before :each do
      @merchant_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "Name 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @merchant_2 = User.create!(email: "user2@gmail.com", password: "password2", role: 1, active: true, name: "Name 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")
      @item_1 = @merchant_1.items.create!(name: "name 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 1)
      @item_2 = @merchant_1.items.create!(name: "name 2", active: true, price: 22.22, description: "description 2", image: "https://bit.ly/2LXAlJy", inventory: 2)
      @item_3 = @merchant_2.items.create!(name: "name 3", active: true, price: 33.33, description: "description 3", image: "https://bit.ly/2LXAlJy", inventory: 3)
      @item_4 = @merchant_2.items.create!(name: "name 4", active: false, price: 44.44, description: "description 4", image: "https://bit.ly/2LXAlJy", inventory: 4)
    end

    it "I see all items in the system that are active" do

      visit items_path

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to_not have_content(@item_4.name)
    end

    it "it displays items attributes for each item" do

      visit items_path

      within("#item-#{@item_1.id}") do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_css("img[src='#{@item_1.image}']")
        expect(page).to have_content(@item_1.user.name)
        expect(page).to have_content(@item_1.inventory)
        expect(page).to have_content(@item_1.price)
        expect(page).to_not have_content(@item_2.name)
      end

      within("#item-#{@item_2.id}") do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_css("img[src='#{@item_2.image}']")
        expect(page).to have_content(@item_2.user.name)
        expect(page).to have_content(@item_2.inventory)
        expect(page).to have_content(@item_2.price)
        expect(page).to_not have_content(@item_1.name)
      end
    end
    it "item name is link to item's show page" do

      visit items_path

      within("#item-#{@item_1.id}") do
        expect(page).to have_link(@item_1.name, href: item_path(@item_1))
      end

      within("#item-#{@item_2.id}") do
        expect(page).to have_link(@item_2.name, href: item_path(@item_2))
      end
    end
    it "item image is link to item's show page"
    context "there are no items in database"
    context "there are no active items in database"
  end
end
