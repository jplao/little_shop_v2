require 'rails_helper'

describe Item, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :price}
    it {should validate_presence_of :inventory_count}
    it {should validate_numericality_of :price}
    it {should validate_numericality_of :inventory_count}
  end

  describe 'Relationships' do
    it {should belong_to :user}
    it {should have_many :order_items}
    it {should have_many(:orders).through(:order_items)}
  end

  describe "Class Methods" do
    it "should reduce inventory for an item" do
      merchant = create(:user, role: 1)
      item = create(:item, inventory_count: 10, user: merchant)
      user = create(:user)
      order = create(:order, user: user)
      order_item = order.order_items.create(item: item, item_quantity: 6)

      Item.reduce_inventory(order_item)

      expect(Item.find(order_item.item_id).inventory_count).to eq(4)
    end

    before(:each) do

      @merch_1, @merch_2, @merch_3, @merch_4, @merch_5, @merch_6 = create_list(:user, 6, role: 1)

      @item_1 = create(:item, user: @merch_1)
      @item_2 = create(:item, user: @merch_2)
      @item_3 = create(:item, user: @merch_3)
      @item_4 = create(:item, user: @merch_4)
      @item_5 = create(:item, user: @merch_5)
      @item_6 = create(:item, user: @merch_6)

      @order = create(:order, status: "complete", user: @merch_6)

      create(:order_item, order: @order, item: @item_1, item_quantity: 2, item_price: 1, fulfill: true)
      create(:order_item, order: @order, item: @item_2, item_quantity: 3, item_price: 3, fulfill: true)
      create(:order_item, order: @order, item: @item_3, item_quantity: 4, item_price: 3, fulfill: false)
      create(:order_item, order: @order, item: @item_4, item_quantity: 5, item_price: 1, fulfill: true)
      create(:order_item, order: @order, item: @item_5, item_quantity: 6, item_price: 1, fulfill: true)
      create(:order_item, order: @order, item: @item_6, item_quantity: 1, item_price: 1, fulfill: true)
    end

    it '.top_items' do
      expect(Item.top_items[0]).to eq (@item_5)
      expect(Item.top_items[1]).to eq (@item_4)
      expect(Item.top_items[2]).to eq (@item_3)
      expect(Item.top_items[3]).to eq (@item_2)
      expect(Item.top_items[4]).to eq (@item_1)
    end

    it ".top_merchant_sales" do
      expect(Item.top_merchant_sales).to include(@merch_4.id)
      expect(Item.top_merchant_sales).to include(@merch_2.id)
      expect(Item.top_merchant_sales).to include(@merch_5.id)
    end
  end
end
