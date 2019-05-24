require 'rails_helper'

RSpec.describe 'As a merchant,', type: :feature do
  describe "when I visit my /dashboard" do
    before :each do
      @merchant = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")

      visit login_path
      fill_in "Email", with: @merchant.email
      fill_in "Password", with: @merchant.password
      click_button "Log In"
    end

    it "I see merchant's info" do
      visit dashboard_path

      within("#merchant-#{@merchant.id}-info") do
        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("Name: #{@merchant.name}")
        expect(page).to have_content("E-Mail: #{@merchant.email}")
        expect(page).to have_content("Address: #{@merchant.address}")
        expect(page).to have_content("City: #{@merchant.city}")
        expect(page).to have_content("State: #{@merchant.state}")
        expect(page).to have_content("Zip: #{@merchant.zip}")
      end
    end
  end
end
