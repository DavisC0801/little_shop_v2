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
        expect(page).to have_link("Register", href: new_user_path)
      end
    end

    describe "I see 6 links in the navigation bar" do
      it "when I click on 'Home', I go to home page" do
        visit items_path

        click_link "Home"

        expect(current_path).to eq(root_path)
      end

      it "when I click on 'Items For Sale', I go to item's index page" do
        visit root_path

        click_link "Items For Sale"

        expect(current_path).to eq(items_path)
      end

      it "when I click on 'Merchants', I go to merchant's index page" do
        visit root_path

        click_link "Merchants"

        expect(current_path).to eq(merchants_path)
      end

      it "when I click on 'My Shopping Cart', I go to my shopping cart's index page" do
        visit root_path

        click_link "My Shopping Cart"

        expect(current_path).to eq(carts_path)
      end

      it "when I click on 'Log In', I go to a log in form" do
        visit root_path

        click_link "Log In"

        expect(current_path).to eq(login_path)
      end

      it "when I click on 'Register', I go to a user registration form" do
        visit root_path

        click_link "Register"

        expect(current_path).to eq(new_user_path)
      end
    end
  end
end
