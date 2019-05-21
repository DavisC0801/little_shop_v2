require "rails_helper"

RSpec.describe "As a registered user" do
  describe "when I visit my own profile page" do
    before do
      @user = User.create!(email: "notmi_reelemail@nope.com", password: "test", \
      role: 3, active: true, name: "Chris", address: "123 Fake St", \
      city: "Denver", state: "Colorado", zip: 12345)
    end

    it "loads a page" do
      visit user_path(@user)

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(user_path(@user))
    end

    it "shows me all data except password" do
      visit user_path(@user)

      within("#user_info") do
        expect(page).to have_content("Name: #{@user.name}")
        expect(page).to have_content("E-Mail: #{@user.email}")
        expect(page).to have_content("Address: #{@user.address}")
        expect(page).to have_content("City: #{@user.city}")
        expect(page).to have_content("State: #{@user.state}")
        expect(page).to have_content("Zip: #{@user.zip}")
      end
    end

    it "shows a link to edit profile data" do
      visit user_path(@user)

      within("#user_info") do
        expect(page).to have_link("Edit your information")
      end
    end
  end
end
