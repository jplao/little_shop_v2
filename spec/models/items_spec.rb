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
  end
end
