require 'rails_helper'

RSpec.describe 'As a admin,', type: :feature do
  describe "I see the same navigation bar as a visitor" do
    before :each do
      @admin = User.create!(email: "user1@gmail.com", password: "password1", role: 1, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it "with admin dashboard, profile and logout links instead of shopping cart, login and register" do
      visit profile_path

      within(".navbar-nav") do
        expect(page).to have_link("Home", href: root_path)
        expect(page).to have_link("Items For Sale", href: items_path)
        expect(page).to have_link("Merchants", href: merchants_path)
        expect(page).to have_link("Dashboard", href: admin_dashboard_path)
        expect(page).to have_link("Profile", href: profile_path)
        expect(page).to have_link("Log Out", href: logout_path)
        expect(page).to_not have_link("My Shopping Cart", href: cart_path)
        expect(page).to_not have_link("Log In", href: login_path)
        expect(page).to_not have_link("Register", href: register_path)
      end
    end
  end
end