require 'rails_helper'

RSpec.describe 'As a visitor,', type: :feature do
  describe "I see a navigation bar" do
    it "that includes links for the following" do
      visit root_path

      within(".navbar-nav") do
        expect(page).to have_link("Home", href: root_path)
        expect(page).to have_link("Items For Sale", href: items_path)
        expect(page).to have_link("Merchants", href: merchants_path)
        expect(page).to have_link("My Shopping Cart", href: carts_path)
        expect(page).to have_link("Log In", href: login_path)
        expect(page).to have_link("Register", href: register_path)
        expect(page).to_not have_link("Users", href: admin_users_path)
      end
    end

    describe "I see 6 links in the navigation bar" do
      it "when I click on a link, I go to correct page" do
        visit items_path

        click_link "Home"
        expect(current_path).to eq(root_path)

        click_link "Items For Sale"
        expect(current_path).to eq(items_path)

        click_link "Merchants"
        expect(current_path).to eq(merchants_path)

        click_link "My Shopping Cart"
        expect(current_path).to eq(cart_path)

        click_link "Log In"
        expect(current_path).to eq(login_path)

        click_link "Register"
        expect(current_path).to eq(register_path)
      end
    end
  end
end
