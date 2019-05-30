# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'as a visitor' do
  before(:each) do
    @user = create(:user)
    @item_1 = create(:item, user: @user)
    @item_2 = create(:item, user: @user)
  end

  it 'displays a message' do
    visit item_path(@item_1)
    click_button 'Add Item'

    expect(page).to have_content("You now have 1 item of #{@item_1.name} in your cart.")
    expect(current_path).to eq(items_path)
  end

  it 'the message for multiple items' do
    visit item_path(@item_1)
    click_button 'Add Item'

    visit item_path(@item_2)
    click_button 'Add Item'

    visit item_path(@item_1)
    click_button 'Add Item'

    expect(page).to have_content("You now have 2 items of #{@item_1.name} in your cart.")
  end

  it 'total of items in the cart' do
    visit item_path(@item_1)

    expect(page).to have_content('Cart: 0')

    click_button 'Add Item'

    expect(page).to have_content('Cart: 1')

    visit item_path(@item_2)
    click_button 'Add Item'

    expect(page).to have_content('Cart: 2')

    visit item_path(@item_1)
    click_button 'Add Item'

    expect(page).to have_content('Cart: 3')
  end

  context 'as a user' do
    before(:each) do
      @merchant_1 = create(:user)
      @item_1 = create(:item, user: @merchant_1, name: 'Picasso')
      @item_2 = create(:item, user: @merchant_1, name: 'Warhol')
      @user_1 = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    it 'displays a message' do
      visit item_path(@item_1)
      click_button 'Add Item'

      expect(page).to have_content("You now have 1 item of #{@item_1.name} in your cart.")
    end

    it 'the message correctly adds multiple items' do
      visit item_path(@item_1)
      click_button 'Add Item'

      visit item_path(@item_2)
      click_button 'Add Item'

      visit item_path(@item_1)
      click_button 'Add Item'

      expect(page).to have_content("You now have 2 items of #{@item_1.name} in your cart.")
    end

    it 'displays the total number of items in the cart' do
      visit item_path(@item_1)

      expect(page).to have_content('Cart: 0')

      click_button 'Add Item'

      expect(page).to have_content('Cart: 1')

      visit item_path(@item_2)
      click_button 'Add Item'

      expect(page).to have_content('Cart: 2')

      visit item_path(@item_1)
      click_button 'Add Item'

      expect(page).to have_content('Cart: 3')
    end
  end
end
