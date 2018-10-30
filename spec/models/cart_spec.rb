require 'rails_helper'

RSpec.describe Cart do

  it '.add_item' do
    cart = Cart.new({
      "1" => 2,
      "2" => 3
      })
    cart.add_item(1)
    cart.add_item(2)
    expect(cart.contents).to eq({
      "1" => 3,
      "2" => 4
      })
  end

  it '.cart_count' do
    cart = Cart.new({
      "1" => 2,
      "2" => 3
      })
    expect(cart.cart_count).to eq(5)
  end

  it '.item_quantity_hash' do
    item_1 = create(:item)
    item_2 = create(:item)

    cart = Cart.new({
      "#{item_1.id}" => 2,
      "#{item_2.id}" => 3
      })

    expect(cart.item_quantity_hash.keys[0]).to eq(item_1)
    expect(cart.item_quantity_hash.values[0]).to eq(2)

    expect(cart.item_quantity_hash.keys[1]).to eq(item_2)
    expect(cart.item_quantity_hash.values[1]).to eq(3)
  end

  it 'contents_hash' do
    item_1 = create(:item)
    item_2 = create(:item)

    cart = Cart.new({
      "#{item_1.id}" => 2,
      "#{item_2.id}" => 3
      })

    expect(cart.item_quantity_hash.keys[0]).to eq(item_1)
    expect(cart.item_quantity_hash.values[0]).to eq(2)

    expect(cart.item_quantity_hash.keys[1]).to eq(item_2)
    expect(cart.item_quantity_hash.values[1]).to eq(3)
  end



end
