require "rails_helper"

RSpec.describe "As a registered user" do
  describe "when I visit my own profile page" do
    before do
      @user = User.create!(email: "notmi_reelemail@nope.com", password: "test", \
      role: 0, active: true, name: "Chris", address: "123 Fake St", \
      city: "Denver", state: "Colorado", zip: 12345)

      allow_any_instance_of(UsersController).to receive(:current_user).and_return(@user)
    end

    it "loads a page" do
      visit profile_path

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(profile_path)
    end

    it "shows me all data except password" do
      visit profile_path

      within("#user-#{@user.id}-info") do
        expect(page).to have_content("Name: #{@user.name}")
        expect(page).to have_content("E-Mail: #{@user.email}")
        expect(page).to have_content("Address: #{@user.address}")
        expect(page).to have_content("City: #{@user.city}")
        expect(page).to have_content("State: #{@user.state}")
        expect(page).to have_content("Zip: #{@user.zip}")
      end
    end

    it "shows a link to edit profile data" do
      visit profile_path

      within("#user-#{@user.id}-info") do
        expect(page).to have_link("Edit your information")
      end
    end
  end
end

RSpec.describe "As an unregistered user" do
  it "shows a 404 page if invalid user_id is entered" do  
    visit profile_path

    expect(current_path).to eq(profile_path)
    expect(page.status_code).to eq(404)
    expect(page).to_not have_content("Name: ")
    expect(page).to_not have_content("E-Mail: ")
    expect(page).to_not have_content("Address: ")
    expect(page).to_not have_content("City: ")
    expect(page).to_not have_content("State: ")
    expect(page).to_not have_content("Zip: ")
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
