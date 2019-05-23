require "rails_helper"

RSpec.describe "As a visitor" do
  describe "when I visit the login path" do
    it "loads a page" do
      visit login_path

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(login_path)
    end
  end
end
