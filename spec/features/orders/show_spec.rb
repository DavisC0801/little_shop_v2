require 'rails_helper'

RSpec.describe "as a registered user", type: :feature do
  describe "when I visit my orders page" do
    before :each do
      @user = User.create!(email: "notmi_reelemail@nope.com",password: "test", name: "Chris", address: "123 Fake St", city: "Denver", state: "Colorado", zip: 12345 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @order_1 = @user.orders.create!
      @order_2 = @user.orders.create!
      @artwork_1 = Item.create!(name: "A Sunday Afternoon on the Island of La Grande Jatte", price: 56000000.00 , description: "design, composition, tension, balance, light, and harmony", image: "https://bit.ly/1C53Ad6", inventory: 1, user_id: @user.id)
      @artwork_2 = Item.create!(name: "Autumn Rhythm", price: 30000000.00 , description: "chaos", image: "https://bit.ly/2VNDT0D", inventory: 1, user_id: @user.id )
      @artwork_3 = Item.create!(name: "Self-Portrait with Thorn Necklace and Hummingbird", price: 16000000.00 , description: "natural beauty", image: "https://bit.ly/1O5A1gr", inventory: 1, user_id: @user.id)
      @order_item_1 = OrderItem.create!(item: @artwork_1, order: @order_1, quantity: 1, price: @artwork_1.price)
      @order_item_1 = OrderItem.create!(item: @artwork_2, order: @order_1, quantity: 1, price: @artwork_2.price)
      @order_item_1 = OrderItem.create!(item: @artwork_3, order: @order_2, quantity: 1, price: @artwork_3.price)
    end

    it "there is a link to specific orders" do
      visit profile_orders_path

      expect(page).to have_link("#{@order_1.id}")
    end

    it "when I click on one of those links, it takes me to that order's page" do
      visit profile_orders_path

      click_link("#{@order_1.id}")

      expect(current_path).to eq(profile_order_path(@order_1))
    end

    it "on an order's page I see all information about that order" do
      visit profile_order_path(@order_1)

      expect(page).to have_content("#{@order_1.id}")
      expect(page).to have_content("#{@order_1.created_at}")
      expect(page).to have_content("#{@order_1.updated_at}")
      expect(page).to have_content("#{@order_1.status}")

      within("#item-#{@artwork_1.id}") do
        expect(page).to have_content("#{@artwork_1.name}")
        expect(page).to have_content("#{@artwork_1.description}")
        expect(page).to have_xpath("//img[contains(@src,'#{@artwork_1.image}')]")
        expect(page).to have_content("#{@artwork_1.order_quantity(@order_1)}")
        expect(page).to have_content("#{@artwork_1.price}")
        expect(page).to have_content("#{@artwork_1.subtotal(@order_1)}")
      end

      expect(page).to have_content("#{@order_1.total_quantity}")
      expect(page).to have_content("#{number_to_currency(@order_1.total_cost)}")
    end
  end
end
