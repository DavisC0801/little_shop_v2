# As a registered user
# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# Then my current URI route is "/profile/edit"
# I see a form like the registration page
# The form contains all of my user information
# The password fields are blank and can be left blank
# I can change any or all of the information
# When I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information

require "rails_helper"

RSpec.describe "As a registered user" do
  describe "when I visit my own profile page" do
    before do
      @user = User.create!(email: "notmi_reelemail@nope.com", password: "test", \
      role: 3, active: true, name: "Chris", address: "123 Fake St", \
      city: "Denver", state: "Colorado", zip: 12345)
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
      click_button  "Submit Changes"
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Patrick")
      expect(page).to_not have_content(@user.name)
      expect(page).to have_content("Patrick@gmail.com")
      expect(page).to have_content("Your Data is Updated")
    end
  end
end
