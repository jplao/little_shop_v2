require 'rails_helper'

RSpec.describe Cart do

  before(:each) do
    @item_1 = create(:item)
    @item_2 = create(:item)
  end

  it '.add_item' do
    cart = Cart.new({
      "#{@item_1.id}" => 2,
      "#{@item_2.id}" => 3
      })
    cart.add_item(@item_1.id)
    cart.add_item(@item_2.id)
    expect(cart.contents).to eq({
      "#{@item_1.id}" => 3,
      "#{@item_2.id}" => 4
      })
  end

  it '.cart_count' do
    cart = Cart.new({
      "#{@item_1.id}" => 2,
      "#{@item_2.id}" => 3
      })
    expect(cart.cart_count).to eq(5)
  end

  it '.item_quantity_hash' do
    cart = Cart.new({
      "#{@item_1.id}" => 2,
      "#{@item_2.id}" => 3
      })

    expect(cart.item_quantity_hash.keys[0]).to eq(@item_1)
    expect(cart.item_quantity_hash.values[0]).to eq(2)

    expect(cart.item_quantity_hash.keys[1]).to eq(@item_2)
    expect(cart.item_quantity_hash.values[1]).to eq(3)
  end

  it 'contents_hash' do

    cart = Cart.new({
      "#{@item_1.id}" => 2,
      "#{@item_2.id}" => 3
      })

    expect(cart.item_quantity_hash.keys[0]).to eq(@item_1)
    expect(cart.item_quantity_hash.values[0]).to eq(2)

    expect(cart.item_quantity_hash.keys[1]).to eq(@item_2)
    expect(cart.item_quantity_hash.values[1]).to eq(3)
  end

end
