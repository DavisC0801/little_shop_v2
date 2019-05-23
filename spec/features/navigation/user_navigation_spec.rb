require 'rails_helper'

RSpec.describe 'As a user,', type: :feature do
  describe "I see the same navigation bar as a visitor" do
    before :each do
      @user = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "with profile and logout links instead of login and register" do
      visit profile_path

      within(".navbar-nav") do
        expect(page).to have_link("Home", href: root_path)
        expect(page).to have_link("Items For Sale", href: items_path)
        expect(page).to have_link("Merchants", href: merchants_path)
        expect(page).to have_link("My Shopping Cart", href: cart_path)
        expect(page).to have_link("Profile", href: profile_path)
        expect(page).to have_link("Log Out", href: logout_path)
        expect(page).to_not have_link("Log In", href: login_path)
        expect(page).to_not have_link("Register", href: register_path)
      end
    end

    it "displays who is logged in on any page" do
      visit profile_path
      expect(page).to have_content("Logged in as #{@user.name}")

      visit items_path
      expect(page).to have_content("Logged in as #{@user.name}")

      visit merchants_path
      expect(page).to have_content("Logged in as #{@user.name}")
    end

    describe "I see 2 new links in the navigation bar" do
      it "when I click on a link, I go to correct page" do
        visit items_path

        click_link "Profile"
        expect(current_path).to eq(profile_path)

        click_link "Log Out"
        expect(current_path).to eq(root_path)
      end
    end
  end
end
