require 'rails_helper'

RSpec.describe "as a registered user", type: :feature do
  describe "when I visit an order's show page" do
    before :each do
      @user = User.create!( email: "notmi_reelemail@nope.com",
        password: "test",
        name: "Chris",
        address: "123 Fake St",
        city: "Denver",
        state: "Colorado",
        zip: 12345 )

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        @order_1 = @user.orders.create!(status: "pending")
        @order_2 = @user.orders.create!(status: "packaged")
        @artwork_1 = Item.create!(name: "A Sunday Afternoon on the Island of La Grande Jatte", price: 56000000.00 , description: "design, composition, tension, balance, light, and harmony", image: "https://bit.ly/2HBZ7e6", inventory: 1, user_id: @user.id)
        @artwork_2 = Item.create!(name: "Autumn Rhythm", price: 30000000.00 , description: "chaos", image: "https://bit.ly/2VNDT0D", inventory: 1, user_id: @user.id )
        @artwork_3 = Item.create!(name: "Self-Portrait with Thorn Necklace and Hummingbird", price: 16000000.00 , description: "natural beauty", image: "https://bit.ly/1O5A1gr", inventory: 1, user_id: @user.id)
        @order_item_1 = OrderItem.create!(item: @artwork_1, order: @order_1, quantity: 1, price: @artwork_1.price)
        @order_item_2 = OrderItem.create!(item: @artwork_2, order: @order_1, quantity: 1, price: @artwork_2.price)
        @order_item_3 = OrderItem.create!(item: @artwork_3, order: @order_2, quantity: 1, price: @artwork_3.price)
      end
    describe "when the order status is 'pending'" do
      it "I see a button to cancel the order" do
        visit profile_order_path(@order_1)

        expect(page).to have_button("Cancel Order")
      end

      it "When I click on the button, the cancellation process runs" do
        visit profile_order_path(@order_1)

        click_button "Cancel Order"

        expect(current_path).to eq(profile_order_path(@order_1))
        expect(page).to have_content("Order #{@order_1.id} has been cancelled")

        expect(@order_item_1.reload.fulfilled).to eq(false)
        expect(@order_item_2.reload.fulfilled).to eq(false)
        expect(@order_1.reload.status).to eq("cancelled")
      end
    end

    describe "when the order is not 'pending'" do
      it "I don't see a button to cancel the order" do
        visit profile_order_path(@order_2)
        expect(page).to_not have_button("Cancel Order")
      end
    end
  end
end
