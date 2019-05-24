
class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def cart_count
    @contents.values.sum
  end

  def item_quantity_hash
    @contents&.each_with_object(Hash.new(0)) do |(item_id, count), hash|
      item = Item.find(item_id)
      hash[item] = count
    end
  end

  def update_item(item_id, method)
    if method == 'more'
      add_item(item_id)
    elsif method == 'less'
      subtact_item(item_id)
    elsif method == 'remove'
      @contents.delete(item_id.to_s)
    end
  end

  def add_item(item_id)
    Item.find(item_id).inventory
    @contents[item_id.to_s] ||= 0
    @contents[item_id.to_s] += 1
  end

  def subtact_item(item_id)
    if @contents[item_id.to_s] > 1
      @contents[item_id.to_s] -= 1
    elsif @contents[item_id.to_s] == 1
      @contents.delete(item_id.to_s)
    end
  end
end
