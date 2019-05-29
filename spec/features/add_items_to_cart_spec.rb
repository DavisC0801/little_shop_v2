require 'rails_helper'

RSpec.describe 'their cart' do
  before(:each) do
    @user1 = create(:user)
    @item1 = Item.create(name: 'Smoker #12', price: 96_000, description: 'Demands attention', inventory: 23, user_id: @user1.id)
    @item2 = Item.create(name: 'Mouth', price: 57_000, description: 'Bold Iconic', inventory: 3, user_id: @user1.id)

    visit item_path(@item1)

    within("#item-#{item.id}") do
      click_button 'Add Item'
    end

    expect(page).to have_content("You now have 1 #{item.name} in your cart.")
  end
end
