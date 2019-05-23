class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  # def cart_count_of
  #   @contents.values.sum
  # end

  def add_item(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def cart_item_total
    @contents.keys.each do |id|
      hash[id] = (contents[id] * Item.find(id).price)
    end
    hash
  end

  # def index
  #   @items = @cart.cart_items
  #   @item_sum = @cart.cart_item_total
  #   @cart_sum = @item_sum.values.sum
  # end
end
