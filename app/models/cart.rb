class Cart

  attr_reader :contents

  def initialize(init_contents)
    @contents = init_contents || Hash.new
  end

  def cart_count
    @contents.values.sum
  end

  def item_quantity_hash
    if @contents
      @contents.inject(Hash.new(0)) do |hash, (item_id, count)|
        item = Item.find(item_id)
        hash[item] = count
        hash
      end
    end
  end

  def update_item(item_id, method)
    if method == "more"
      add_item(item_id)
    elsif method == "less"
      subtact_item(item_id)
    elsif method == "remove"
      @contents.delete(item_id.to_s)
    end
  end

  def add_item(item_id)
    item_count = Item.find(item_id).inventory_count
    @contents[item_id.to_s] ||= 0
    if @contents[item_id.to_s] < item_count
      @contents[item_id.to_s] += 1
    end
  end

  def subtact_item(item_id)
    if @contents[item_id.to_s] > 1
      @contents[item_id.to_s] -= 1
    elsif @contents[item_id.to_s] == 1
      @contents.delete(item_id.to_s)
    end
  end

end
