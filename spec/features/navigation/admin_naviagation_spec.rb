require 'rails_helper'

RSpec.describe 'As a admin,', type: :feature do
  describe "I see the same navigation bar as a visitor" do
    before :each do
      @admin = User.create!(email: "user1@gmail.com", password: "password1", role: 1, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it "with admin dashboard and logout links instead of profile, shopping cart, login and register" do
      visit root_path

      within(".navbar-nav") do
        expect(page).to have_link("Home", href: root_path)
        expect(page).to have_link("Items For Sale", href: items_path)
        expect(page).to have_link("Merchants", href: merchants_path)
        expect(page).to have_link("Dashboard", href: admin_dashboard_path)
        expect(page).to have_link("Dashboard", href: admin_dashboard_path)
        expect(page).to have_link("Users", href: admin_users_path)
        expect(page).to_not have_link("Profile", href: profile_path)
        expect(page).to_not have_link("My Shopping Cart", href: cart_path)
        expect(page).to_not have_link("Log In", href: login_path)
        expect(page).to_not have_link("Register", href: register_path)
      end
    end

    describe "I see admin links in the navigation bar" do
      it "when I click on dashboard link, I go to correct page" do
        visit items_path

        click_link "Dashboard"
        expect(current_path).to eq(admin_dashboard_path)
      end

      it "when I click on Users link, I go to correct page" do
        visit items_path

        click_link "Users"
        expect(current_path).to eq(admin_users_path)
      end
    end

    it "should not show merchant's dashboard in navigation bar" do
      visit root_path

      within(".navbar-nav") do
        expect(page).to_not have_link("Dashboard", href: dashboard_path)
      end
    end
  end
end
