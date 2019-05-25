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

    describe "when I have orders placed in the system" do
      before do
        order_1 = @user.orders.create
        order_2 = @user.orders.create
        artwork_1 = order_1.items.create(name: "A Sunday Afternoon on the Island of La Grande Jatte", price: 56_000_000 , description: "design, composition, tension, balance, light, and harmony", image: "https://bit.ly/1C53Ad6", inventory: 1)
        artwork_2 = order_1.items.create(name: "Autumn Rhythm", price: 30_000_000 , description: "chaos", image: "https://bit.ly/2VNDT0D", inventory: 1 )
        artwork_3 = order_2.items.create(name: "Self-Portrait with Thorn Necklace and Hummingbird", price: 16_000_000 , description: "natural beauty", image: "https://bit.ly/1O5A1gr", inventory: 1)
      end

      it "I see a link on my profile page called 'My Orders'" do
        visit profile_path

        expect(page).to have_link("My Orders")
      end

      it "When I click 'My Orders' link, I am taken to /profile/orders/" do
        visit profile_path

        click_link("My Orders")
        
        expect(current_path).to eq(profile_orders_path)
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
