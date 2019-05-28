# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'When a user adds an item to their cart', type: :feature do
  before :each do
    @user = create(:user)
    @item1, @item2 = create_list(:item, 2, user: @user)
  end

  it 'allows me to add a item to the cart and displays a message' do
    visit item_path(@item2)

    click_on "Add Item"

    expect(current_path).to eq(items_path)
    expect(page).to have_content("You now have 1 item of #{@item2.name} in your cart.")
  end
end
