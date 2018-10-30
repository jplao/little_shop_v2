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
    else
      {}
    end
  end

  private

  def add_item(item_id)
    if Item.find(item_id).inventory_count > 0
      @contents[item_id.to_s] ||= 0
      @contents[item_id.to_s] += 1
    else

    end


    def subtact_item

    end

end
