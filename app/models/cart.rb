class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def count_of(item_id)
    @contents[item_id.to_s].to_i
  end

  def total_count
    @contents.sum { |item_id, quantity| quantity.to_i }
  end

  def add_item(item_id)
    @contents[item_id.to_s] = count_of(item_id.to_s) + 1
  end

  def remove(item_id)
    @contents[item_id.to_s] = count_of(item_id.to_s) - 1
    @contents.delete(item_id.to_s) if @contents[item_id.to_s] <= 0
  end

  def item_and_quantity
    @contents.map do |item_id, quantity|
      [Item.find(item_id.to_i), quantity]
    end.to_h
  end

  def clear_item(item_id)
    @contents.delete(item_id.to_s)
  end

  def subtotal(item)
    quantity = item_and_quantity[item]
    item.price * quantity.to_i
  end

  def total
    item_and_quantity.sum do |item, quantity|
      item.price * quantity.to_i
    end
  end
end
