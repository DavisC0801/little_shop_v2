require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit the merchant's index page at '/merchants'" do
    it "loads a page" do
      visit merchants_path

      expect(current_path).to eq(merchants_path)
      expect(page.status_code).to eq(200)
    end

    it "shows all merchants that are active" do
      visit merchants_path
      
    end

    it "shows the city and state of each merchant" do
      visit merchants_path

    end

    it "shows the date they registered" do
      visit merchants_path

    end
  end
end
