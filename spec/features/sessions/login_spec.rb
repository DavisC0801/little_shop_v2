require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit the login path" do
    it "loads a page" do
      visit login_path

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(login_path)
    end
  end

  describe "When I visit login path And I submit invalid information" do
    it "redirects to the login page and I see a messaging telling me credentials were incorrect" do

      @user = User.create!(email: "user@user.com", password: "user", \
      role: 0, active: true, name: "User", address: "123 Fake St", \
      city: "Denver", state: "Colorado", zip: 12345)

      visit login_path

      fill_in "Email", with: "user5@user.com"
      fill_in "Password", with: "user"

      click_button "Log In"

      expect(current_path).to eq(login_path)

      expect(page).to have_content("Your credentials was entered incorrectly.")
    end
  end
end

RSpec.describe "As a registered user" do
  describe "as a user" do
    before :each do
      @user = User.create!(email: "user@user.com", password: "user", \
      role: 0, active: true, name: "User", address: "123 Fake St", \
      city: "Denver", state: "Colorado", zip: 12345)
    end

    it "when I enter my valid information it takes me to my profile page" do
      visit login_path

      fill_in "Email", with: "user@user.com"
      fill_in "Password", with: "user"

      click_button "Log In"

      expect(current_path).to eq(profile_path)

      expect(page).to have_content("Welcome, #{@user.name}! You're now logged in!")
    end

    context "when I am logged in" do
      it "redirects to profile and gives a message" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit login_path

        expect(current_path).to eq(profile_path)

        expect(page).to have_content("You are already logged in.")
      end
    end
  end

  describe "as a merchant" do
    before :each do
      @merchant = User.create!(email: "merchant@merchant.com", password: "merchant", \
      role: 2, active: true, name: "Merchant", address: "123 Fake St", \
      city: "Denver", state: "Colorado", zip: 12345)
    end

    it "when I enter my valid information it takes me to my dashboard page" do
      visit login_path

      fill_in "Email", with: "merchant@merchant.com"
      fill_in "Password", with: "merchant"

      click_button "Log In"

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Welcome, #{@merchant.name}! You're now logged in!")
    end

    context "when I am logged in" do
      it "redirects to profile and gives a message" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
        visit login_path

        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content("You are already logged in.")
      end
    end
  end

  describe "as an admin" do
    before :each do
      @admin = User.create!(email: "admin@admin.com", password: "admin", \
      role: 1, active: true, name: "Admin", address: "123 Fake St", \
      city: "Denver", state: "Colorado", zip: 12345)
    end

    it "when I enter my valid information it takes me to the home page" do
      visit login_path

      fill_in "Email", with: "admin@admin.com"
      fill_in "Password", with: "admin"

      click_button "Log In"

      expect(current_path).to eq(root_path)

      expect(page).to have_content("Welcome, #{@admin.name}! You're now logged in!")
    end

    context "when I am logged in" do
      it "redirects to profile and gives a message" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
        visit login_path

        expect(current_path).to eq(root_path)

        expect(page).to have_content("You are already logged in.")
      end
    end
  end
end
