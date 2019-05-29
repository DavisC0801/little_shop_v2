require 'rails_helper'

RSpec.describe "As a visitor," do
  it "the logout path is unavailable." do
    visit root_path

    expect(page).to_not have_link("Log Out", href: logout_path)
  end
end

RSpec.describe "As a registered user," do
  describe "user can click 'Log Out'" do
    before :each do
      @user = User.create!(email: "user1@gmail.com", password: "password1", role: 0, active: true, name: "User 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @merchant = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")
      @item_1 = @merchant.items.create!(name: "Item 1", active: true, price: 11.11, description: "description 1", image: "https://bit.ly/2LXAlJy", inventory: 1)
      @item_2 = @merchant.items.create!(name: "Item 2", active: true, price: 22.22, description: "description 2", image: "https://bit.ly/2LXAlJy", inventory: 2)

      visit login_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log In"
    end

    it "and directed to home page" do
      visit profile_path
      click_link "Log Out"

      expect(current_path).to eq(root_path)
    end

    it "and see a flash message that indicates logged out" do
      visit profile_path
      click_link "Log Out"

      expect(page).to have_content("You're now logged off!")
    end

    # xit "and any items in shopping cart are deleted" do
    #   visit items_path
    #
    #   within("#item-#{@item_1.id}") do
    #     click_button "Add Item"
    #   end
    #
    #   within("#item-#{@item_2.id}") do
    #     click_button "Add Item"
    #   end
    #
    #   expect(page).to have_content('Cart: 2')
    #
    #   click_link "Log Out"
    #
    #   expect(page).to have_content('Cart: 0')
    # end
  end

  describe "merchant can click 'Log Out'" do
    before :each do
      @merchant = User.create!(email: "merchant1@gmail.com", password: "password1", role: 2, active: true, name: "Merchant 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")

      visit login_path
      fill_in "Email", with: @merchant.email
      fill_in "Password", with: @merchant.password
      click_button "Log In"
    end

    it "and directed to home page" do
      visit profile_path
      click_link "Log Out"

      expect(current_path).to eq(root_path)
    end

    it "and see a flash message that indicates logged out" do
      visit profile_path
      click_link "Log Out"

      expect(page).to have_content("You're now logged off!")
    end
  end

  describe "admin can click 'Log Out'" do
    before :each do
      @admin = User.create!(email: "admin1@gmail.com", password: "password1", role: 1, active: true, name: "Admin 1", address: "1 Fake St", city: "city 1", state: "state 1", zip: "12345")

      visit login_path
      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password
      click_button "Log In"
    end

    it "and directed to home page" do
      visit profile_path
      click_link "Log Out"

      expect(current_path).to eq(root_path)
    end

    it "and see a flash message that indicates logged out" do
      visit profile_path
      click_link "Log Out"

      expect(page).to have_content("You're now logged off!")
    end
  end
end
