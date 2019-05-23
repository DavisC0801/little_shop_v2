# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart do
  describe '#cart_item_total' do
    it 'can calculate the total number of items it holds' do
      cart = Cart.new(
        1 => 2, # two copies of item1
        2 => 1 # three copies of item2
      )

      @item1 = Item.create(name: 'Smoker #12', price: 96_000, description: 'Demands attention', inventory: 23, user_id: @user1.id)
      @item2 = Item.create(name: 'Mouth', price: 57_000, description: 'Bold Iconic', inventory: 3, user_id: @user1.id)

      expect(cart.cart_item_total).to eq(3)
    end
  end
end
