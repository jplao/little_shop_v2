require 'rails_helper'

describe Order, type: :model do

  describe 'Relationships' do
    it {should belong_to :user}
    it {should have_many :order_items}
    it {should have_many(:items).through(:order_items)}
  end
  describe "instance methods" do
    it "count total items in an order" do
      @user = create(:user)
      @order = @user.orders.create(status: "pending")
      @order_2 = @user.orders.create(status: "complete")
      @order_3 = @user.orders.create(status: "canceled")

      @item, @item_2 = create_list(:item, 2)
      order_item = @order.order_items.create(item: @item, item_price: 4.00, item_quantity: 3)
      order_item_2 = @order.order_items.create(item: @item_2, item_price: 2.00, item_quantity: 1)

      expect(@order.item_count).to eq(4)
    end
  end 
end
