require 'rails_helper'

RSpec.describe "as a registered user", type: :feature do
  describe "when I visit my orders page" do
    before :each do
      @user = User.create!(email: "notmi_reelemail@nope.com",
                           password: "test",
                           name: "Chris",
                           address: "123 Fake St",
                           city: "Denver",
                           state: "Colorado",
                           zip: 12345 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @order_1 = @user.orders.create
      @order_2 = @user.orders.create
    end

    it "I see each order and a selection of its attributes" do

      visit profile_orders_path

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
