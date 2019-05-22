require 'rails_helper'

RSpec.describe 'As any kind of user,', type: :feature do
  describe "when I visit an item's show page '/items/:id'" do
    before :each do
      @merchant_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @item_1 = @merchant_1.items.create!(name: "Item 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 1)
    end

    it "it displays item's attributes" do

      visit item_path(@item_1)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_css("img[src='#{@item_1.image}']")
      expect(page).to have_content(@item_1.user.name)
      expect(page).to have_content(@item_1.inventory)
      expect(page).to have_content(@item_1.price)
    end

    xit "it displays average amount of time it takes merchant to fulfill item"
    xit "it displays a link to add this item to cart"
  end
end
