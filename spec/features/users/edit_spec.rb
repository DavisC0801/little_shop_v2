require "rails_helper"

RSpec.describe "As a registered user" do
  describe "when I visit my own profile page" do
    before do
      @user = User.create!(email: "notmi_reelemail@nope.com", password: "test", role: 0, active: true, name: "Chris", address: "123 Fake St", city: "Denver", state: "Colorado", zip: 12345)
      @gracie = User.create!(email: "laura_grace_davis@gmail.com", password: "1283florida_miners;", role: 0, active: true, name: "Laura", address: "99836 Wilchester Dr.", city: "Houston", state: "Texas", zip: 77079)

      allow_any_instance_of(UsersController).to receive(:current_user).and_return(@user)
    end

    it "shows link to edit profile" do
      visit profile_path

      click_link("Edit Profile")

      expect(current_path).to eq(profile_edit_path)
    end

    it "displays user data" do
      visit profile_edit_path

      expect(find_field('user_name').value).to eq @user.name
      expect(find_field('user_password').value).to eq nil
      expect(find_field('user_address').value).to eq @user.address
      expect(find_field('user_email').value).to eq @user.email
      expect(find_field('user_city').value).to eq @user.city
      expect(find_field('user_state').value).to eq @user.state
      expect(find_field('user_zip').value).to eq @user.zip
    end

    it "lets me edit user data" do
      visit profile_edit_path

      fill_in "user_name", with: "Patrick"
      fill_in "user_email", with: "Patrick@gmail.com"
      fill_in "user_password", with: "Gobbletygoock"
      fill_in "user_password_confirmation", with: "Gobbletygoock"

      click_button  "Submit Changes"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Patrick")
      expect(page).to_not have_content("Chris")
      expect(page).to have_content("Patrick@gmail.com")
      expect(page).to have_content("Your profile has been updated.")
    end

    it "leaving password blank when editing profile" do
      expected = @user.password
      visit profile_edit_path
      fill_in "user_name", with: "Patrick"
      fill_in "user_email", with: "Patrick@gmail.com"
      click_button  "Submit Changes"
      expect(current_path).to eq(profile_path)
      expect(@user.reload.password).to eq(expected)
    end

    it "entering email already in db elicits error message" do
      visit profile_edit_path
      fill_in "user_email", with: "laura_grace_davis@gmail.com"
      click_button  "Submit Changes"
      expect(current_path).to eq(profile_edit_path)
      expect(page).to have_content("Email has already been taken")
    end
  end
end
