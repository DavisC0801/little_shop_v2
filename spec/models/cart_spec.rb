require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({'1' => 2, '2' => 3}) }

  describe "#total" do
    it "calculates the total number of items it holds" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_item" do
    it "adds a item to its contents" do
      subject.add_item(1)
      subject.add_item(2)
      expect(subject.contents).to eq({'1' => 3, '2' => 4})
    end

    it "add new item" do
      subject.add_item('3')
      expect(subject.contents).to eq({'1' => 2, '2' => 3, '3' => 1})
    end
  end

  describe "#subtotal" do
    it "calculates the subtotal for item" do
      item_1 = create(:item)
      item_2 = create(:item)
      cart_1 = Cart.new({item_1.id.to_s => 2, item_2.id.to_s => 3})
      expect(cart_1.subtotal(item_1)).to eq(2 * item_1.price)
      expect(cart_1.subtotal(item_2)).to eq(3 * item_2.price)
    end
  end

  describe "#total" do
    it "calculates the total" do
      item_1 = create(:item)
      item_2 = create(:item)
      cart_1 = Cart.new({item_1.id.to_s => 2, item_2.id.to_s => 3})
      expect(cart_1.total).to eq(2 * item_1.price + 3 * item_2.price)
    end
  end

  describe "#remove" do
    it "remove an item from cart" do
      subject.remove_item(1)
      subject.remove_item(2)
      expect(subject.contents).to eq({'1' => 1, '2' => 2})
      subject.remove_item(1)
      expect(subject.contents).to eq({'2' => 2})
    end
  end

  describe "#remove_all" do
    it "removes the item from cart" do
      subject.remove_all_item(1)
      expect(subject.contents).to eq({'2' => 3})
    end
  end

end
