require 'rails_helper'

RSpec.describe 'Users should see a 404 error under the following conditions', type: :feature do
  before :each do
    @user_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
    @user_2 = User.create!(email: "user2@gmail.com", password: "password2", role: 0, active: true, name: "User 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")

    @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
    @merchant_2 = User.create!(email: "merchant2@gmail.com", password: "password2", role: 2, active: true, name: "Merchant 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")

    @admin_1 = User.create!(email: "admin1@gmail.com", password: "password1", role: 1, active: true, name: "Admin 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
    @admin_2 = User.create!(email: "admin2@gmail.com", password: "password2", role: 1, active: true, name: "Admin 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")
  end

  describe "if visitors try to navigate to" do
    it "any /profile path" do
      visit profile_path
      expect(page.status_code).to eq(404)
    end

    it "any /dashboard path" do
      visit dashboard_items_path
      expect(page.status_code).to eq(404)
    end

    it "any /admin path" do
      visit admin_dashboard_path
      expect(page.status_code).to eq(404)
      visit admin_users_path
      expect(page.status_code).to eq(404)
      visit admin_user_path(@user_1)
      expect(page.status_code).to eq(404)
    end
  end

  describe "if registered users try to navigate to" do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    it "any /dashboard path" do
      visit dashboard_items_path
      expect(page.status_code).to eq(404)
    end

    it "any /admin path" do
      visit admin_dashboard_path
      expect(page.status_code).to eq(404)
      visit admin_users_path
      expect(page.status_code).to eq(404)
      visit admin_user_path(@user_1)
      expect(page.status_code).to eq(404)
    end
  end

  describe "if merchants try to navigate to" do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    end

    it "any /profile path" do
      visit profile_path
      expect(page.status_code).to eq(404)
    end

    it "any /admin path" do
      visit admin_dashboard_path
      expect(page.status_code).to eq(404)
      visit admin_users_path
      expect(page.status_code).to eq(404)
      visit admin_user_path(@user_1)
      expect(page.status_code).to eq(404)
    end

    it "any /cart path" do
      visit cart_path
      expect(page.status_code).to eq(404)
    end
  end

  describe "if admins try to navigate to" do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
    end

    it "any /profile path" do
      visit profile_path
      expect(page.status_code).to eq(404)
    end

    it "any /dashboard path" do
      visit dashboard_items_path
      expect(page.status_code).to eq(404)
    end

    it "any /cart path" do
      visit cart_path
      expect(page.status_code).to eq(404)
    end
  end
end
