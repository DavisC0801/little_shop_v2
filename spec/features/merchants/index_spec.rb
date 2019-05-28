require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit the merchant's index page at '/merchants'" do
    before :each do
      @merchant_1 = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      travel 1.day
      @merchant_2 = User.create!(email: "merchant2@gmail.com", password: "password2", role: 2, active: true, name: "Merchant 2", address: "2 Fake St", city: "city 2", state: "state 2", zip: "23456")
      travel 1.day
      @merchant_3 = User.create!(email: "merchant3@gmail.com", password: "password3", role: 2, active: true, name: "Merchant 3", address: "3 Fake St", city: "city 3", state: "state 3", zip: "34567")
      travel 1.day
      @merchant_4 = User.create!(email: "merchant4@gmail.com", password: "password4", role: 2, active: true, name: "Merchant 4", address: "4 Fake St", city: "city 4", state: "state 4", zip: "45678")
      travel 1.day
      @merchant_5 = User.create!(email: "merchant5@gmail.com", password: "password5", role: 2, active: true, name: "Merchant 5", address: "5 Fake St", city: "city 5", state: "state 5", zip: "56789")
      travel_back
      @user_1 = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "User 1", address: "11 Fake St", city: "city 11", state: "state 11", zip: "12345")
      @admin_1 = User.create!(email: "admin1@gmail.com", password: "password1", role: 1, active: true, name: "Admin 1", address: "111 Fake St", city: "city 111", state: "state 111", zip: "12345")
    end
    it "loads a page" do
      visit merchants_path

      expect(current_path).to eq(merchants_path)
      expect(page.status_code).to eq(200)
    end

    it "shows all merchants that are active" do
      visit merchants_path

      within("#merchant-#{@merchant_1.id}-info") do
        expect(page).to have_content("Name: #{@merchant_1.name}")
      end
      within("#merchant-#{@merchant_2.id}-info") do
        expect(page).to have_content("Name: #{@merchant_2.name}")
      end
      within("#merchant-#{@merchant_3.id}-info") do
        expect(page).to have_content("Name: #{@merchant_3.name}")
      end
      within("#merchant-#{@merchant_4.id}-info") do
        expect(page).to have_content("Name: #{@merchant_4.name}")
      end
      within("#merchant-#{@merchant_5.id}-info") do
        expect(page).to have_content("Name: #{@merchant_5.name}")
      end
      expect(page).to_not have_content("Name: #{@user_1.name}")
      expect(page).to_not have_content("Name: #{@admin_1.name}")
    end

    it "shows the city and state of each merchant" do
      visit merchants_path

      within("#merchant-#{@merchant_1.id}-info") do
        expect(page).to have_content("City: #{@merchant_1.city}")
        expect(page).to have_content("State: #{@merchant_1.state}")
        expect(page).to have_content("Zip: #{@merchant_1.zip}")
      end
      within("#merchant-#{@merchant_2.id}-info") do
        expect(page).to have_content("City: #{@merchant_2.city}")
        expect(page).to have_content("State: #{@merchant_2.state}")
        expect(page).to have_content("Zip: #{@merchant_2.zip}")
      end
      within("#merchant-#{@merchant_3.id}-info") do
        expect(page).to have_content("City: #{@merchant_3.city}")
        expect(page).to have_content("State: #{@merchant_3.state}")
        expect(page).to have_content("Zip: #{@merchant_3.zip}")
      end
      within("#merchant-#{@merchant_4.id}-info") do
        expect(page).to have_content("City: #{@merchant_4.city}")
        expect(page).to have_content("State: #{@merchant_4.state}")
        expect(page).to have_content("Zip: #{@merchant_4.zip}")
      end
      within("#merchant-#{@merchant_5.id}-info") do
        expect(page).to have_content("City: #{@merchant_5.city}")
        expect(page).to have_content("State: #{@merchant_5.state}")
        expect(page).to have_content("Zip: #{@merchant_5.zip}")
      end
      expect(page).to_not have_content("Name: #{@user_1.state}")
      expect(page).to_not have_content("Name: #{@user_1.city}")
      expect(page).to_not have_content("Name: #{@admin_1.state}")
      expect(page).to_not have_content("Name: #{@admin_1.city}")
    end

    it "shows the date they registered" do
      visit merchants_path

      within("#merchant-#{@merchant_1.id}-info") do
        expect(page).to have_content("Member since: #{Date.today + 1}")
      end
      within("#merchant-#{@merchant_2.id}-info") do
        expect(page).to have_content("Member since: #{Date.today + 2}")
      end
      within("#merchant-#{@merchant_3.id}-info") do
        expect(page).to have_content("Member since: #{Date.today + 3}")
      end
      within("#merchant-#{@merchant_4.id}-info") do
        expect(page).to have_content("Member since: #{Date.today + 4}")
      end
      within("#merchant-#{@merchant_5.id}-info") do
        expect(page).to have_content("Member since: #{Date.today + 5}")
      end
    end
  end
end
