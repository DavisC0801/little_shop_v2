require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I click on the 'register' link in the nav bar" do
    it "Then I am on the user registration page" do
      visit root_path

      click_on "Register"

      expect(current_path).to eq(new_user_path)
    end

    it "And I see a form where I input the following data:" do
      visit root_path

      click_on "Register"

      fill_in "Name", with: "Logan"
      fill_in "Address", with: "123 Donut St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "Colorado"
      fill_in "Zip", with: 80201
      fill_in "Email", with: "loganiscool@loljk.com"
      fill_in "Password", with: "logandonuts15"
      fill_in "Password confirmation", with: "logandonuts15"

      click_on "Create User"

      new_user = User.last

      expect(new_user.name).to eq("Logan")
      expect(current_path).to eq(register_path)
      expect(page).to have_content("Welcome, #{new_user.name}!")
    end

    it "check to see if current user's role equal 'user'"


    it "should not create a new user with a saved email" do

      user = User.create!(name: "Logan", address: "123 Donut St", city: "Denver", state: "Colorado", zip: 80201, email: "loganiscool@loljk.com", password: "logandonuts15", password_confirmation: "logandonuts15")

      visit root_path

      click_on "Register"

      fill_in "Name", with: "Logan"
      fill_in "Address", with: "123 Donut St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "Colorado"
      fill_in "Zip", with: 80201
      fill_in "Email", with: "loganiscool@loljk.com"
      fill_in "Password", with: "logandonuts15"
      fill_in "Password confirmation", with: "logandonuts15"

      click_on "Create User"

      new_user = User.last

      expect(user).to eq(new_user)
      expect(page).to have_content("Email has already been taken")
    end

    it "confirms the password and prompts to re enter if not correct" do
      visit root_path

      click_on "Register"

      fill_in "Name", with: "Logan"
      fill_in "Address", with: "123 Donut St"
      fill_in "City", with: "Denver"
      fill_in "State", with: "Colorado"
      fill_in "Zip", with: 80201
      fill_in "Email", with: "loganiscool@loljk.com"
      fill_in "Password", with: "logandonuts15"
      fill_in "Password confirmation", with: "logandonuts14"

      click_on "Create User"
save_and_open_page
      expect(page).to have_content("Please reconfirm password")
    end
    #
    # xit "logs me in as a registered user" do
    #   visit root_path
    #
    #   click_on "Register"
    #
    #   expect(current_path).to eq(new_user_path)
    #
    #   fill_in "Name", with: "Logan"
    #   fill_in "Address", with: "123 Donut St"
    #   fill_in "City", with: "Denver"
    #   fill_in "State", with: "Colorado"
    #   fill_in "Zip", with: 80201
    #   fill_in "Email", with: "loganiscool@loljk.com"
    #   fill_in "Password", with: "logandonuts15"
    #   fill_in "Password confirmation", with: "logandonuts15"
    #
    #   click_on "Create User"
    #
    #   new_user = User.last
    #
    #   expect(current_path).to eq(profile_path(new_user))
    #
    #   expect(page).to have_content("Welcome, #{new_user.name}!")
    # end
    #
    # xit "logs me in as a registered user" do
    #   visit root_path
    #
    #   click_on "Register"
    #
    #   expect(current_path).to eq(new_user_path)
    #
    #   fill_in "Name", with: "Logan"
    #   fill_in "Address", with: "123 Donut St"
    #   fill_in "City", with: "Denver"
    #   fill_in "State", with: "Colorado"
    #   fill_in "Zip", with: 80201
    #   fill_in "Email", with: "loganiscool@loljk.com"
    #   fill_in "Password", with: "logandonuts15"
    #   fill_in "Password confirmation", with: "logandonuts15"
    #
    #   click_on "Create User"
    #
    #   new_user = User.last
    #
    #   expect(current_path).to eq(profile_path(new_user))
    #
    #   expect(page).to have_content("Welcome, #{new_user.name}!")
    # end
  end
end
# As a visitor
# When I click on the 'register' link in the nav bar
# Then I am on the user registration page
# And I see a form where I input the following data:
#
#   my name
#   my street address
#   my city
#   my state
#   my zip code
#   my email address
#   my preferred password
#   a confirmation field for my password
# When I fill in this form completely,
#
#   And with a unique email address not already in the system
#   My details are saved in the database
#   Then I am logged in as a registered user
#   I am taken to my profile page ("/profile")
#   I see a flash message indicating that I am now registered and logged in
