require 'rails_helper'

RSpec.describe "as a registered user" do
  describe "when I visit my orders page" do
    before do
      @user = User.create!(email: "notmi_reelemail@nope.com", password: "test", \
      role: 0, active: true, name: "Chris", address: "123 Fake St", \
      city: "Denver", state: "Colorado", zip: 12345)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @order_1 = @user.orders.create
      @order_2 = @user.orders.create
      @artwork_1 = @order_1.items.create(name: "A Sunday Afternoon on the Island of La Grande Jatte", price: 56_000_000 , description: "design, composition, tension, balance, light, and harmony", image: "https://bit.ly/1C53Ad6", inventory: 1)
      @artwork_2 = @order_1.items.create(name: "Autumn Rhythm", price: 30_000_000 , description: "chaos", image: "https://bit.ly/2VNDT0D", inventory: 1 )
      @artwork_3 = @order_2.items.create(name: "Self-Portrait with Thorn Necklace and Hummingbird", price: 16_000_000 , description: "natural beauty", image: "https://bit.ly/1O5A1gr", inventory: 1)
    end

    it "I see each order and a selection of its attributes" do

      visit profile_orders_path
      save_and_open_page
      within("#order-#{@order_1.id}") do
        expect(page).to have_content("#{@order_1.id}")
        expect(page).to have_content("#{@order_1.created_at}")
        expect(page).to have_content("#{@order_1.updated_at}")
        expect(page).to have_content("#{@order_1.status}")
        expect(page).to have_content("#{@order_1.total_quantity}")
        expect(page).to have_content("#{number_to_currency(@order_1.grand_total)}")
      end

      within("#order-#{@order_2.id}") do
        expect(page).to have_content("#{@order_2.id}")
        expect(page).to have_content("#{@order_2.created_at}")
        expect(page).to have_content("#{@order_2.updated_at}")
        expect(page).to have_content("#{@order_2.status}")
        expect(page).to have_content("#{@order_2.total_quantity}")
        expect(page).to have_content("#{number_to_currency(@order_2.grand_total)}")
      end
    end
  end
end
