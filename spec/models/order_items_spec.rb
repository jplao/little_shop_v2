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

  describe 'Instance Methods' do
    it "should return an item associated with an order-item" do
      @merchant = create(:user, role: 1)
      @customer = create(:user)
      @item = create(:item)
      @order = create(:order)
      @merchant.items = [@item]
      @order_item = @order.order_items.create(item: @item, item_price: 1.99, item_quantity: 10)
      @customer.orders = [@order]

      expect(@order_item.associated_id(@order_item)).to eq(@item)
    end
  end
end
