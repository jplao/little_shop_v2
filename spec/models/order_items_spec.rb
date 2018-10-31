require 'rails_helper'

describe OrderItem, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :item_quantity}
    it {should validate_presence_of :item_price}

  end

  describe 'Relationships' do
    it {should belong_to :item}
    it {should belong_to :order}
  end

  describe 'Class Methods' do
    it '.cart_checkout' do
      item_1, item_2, item_3 = create_list(:item, 3)

      cart = {
        "#{item_1.id}" => 3,
        "#{item_2.id}" => 2,
        "#{item_3.id}" => 1
      }
      expect(OrderItem.cart_checkout(cart)[0].item_id).to eq (item_1.id)
      expect(OrderItem.cart_checkout(cart)[0].item_quantity).to eq (3)
      expect(OrderItem.cart_checkout(cart)[0].item_price).to eq (item_1.price)

      expect(OrderItem.cart_checkout(cart)[1].item_id).to eq (item_2.id)
      expect(OrderItem.cart_checkout(cart)[1].item_quantity).to eq (2)
      expect(OrderItem.cart_checkout(cart)[1].item_price).to eq (item_2.price)

      expect(OrderItem.cart_checkout(cart)[2].item_id).to eq (item_3.id)
      expect(OrderItem.cart_checkout(cart)[2].item_quantity).to eq (1)
      expect(OrderItem.cart_checkout(cart)[2].item_price).to eq (item_3.price)

    end
  end
end
