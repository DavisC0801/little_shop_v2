require 'rails_helper'

RSpec.describe 'Welcome Index Spec:', type: :feature do
  describe "As a visitor," do
    describe "I see a navigation bar" do
      it "that includes links for the following" do
        visit root_path

        within(".navbar-nav") do
          expect(page).to have_link("Home", href: root_path)
          expect(page).to have_link("Items For Sale", href: items_path)
          expect(page).to have_link("Merchants", href: merchants_path)
          expect(page).to have_link("My Shopping Cart", href: cart_path)
          expect(page).to have_link("Log In", href: login_path)
          expect(page).to have_link("User Registration", href: new_user_path)
        end
      end
    end
  end
end
