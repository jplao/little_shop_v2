require 'rails_helper'

describe Order, type: :model do

  describe 'Relationships' do
    it {should belong_to :user}
    it {should have_many :order_items}
    it {should have_many(:items).through(:order_items)}
  end
  describe "instance methods" do
    before(:each) do
      @user = create(:user, state: "CO", city: "Denver")
      @user_2 = create(:user, state: "CA", city: "San Fran")
      @user_3 = create(:user, state: "TN", city: "Chattanooga")
      @user_4 = create(:user, state: "TN", city: "Knoxville")
      @user_5 = create(:user, state: "TN", city: "Nashville")
      @user_6 = create(:user, state: "CO", city: "Boulder")
      @user_7 = create(:user, state: "CO", city: "Ft Collins")
      @user_8 = create(:user, state: "CA", city: "San Diego")
      @user_9 = create(:user, state: "CA", city: "Los Angeles")

      @merchant = create(:user, role: 1)
      @item, @item_2 = create_list(:item, 2, user: @merchant)

      @order_1 = @user.orders.create(status: "complete")
      @order_2 = @user.orders.create(status: "complete")
      @order_3 = @user_2.orders.create(status: "complete")
      @order_4 = @user_3.orders.create(status: "complete")
      @order_5 = @user_4.orders.create(status: "complete")
      @order_6 = @user_5.orders.create(status: "complete")
      @order_7 = @user_3.orders.create(status: "pending")
      @order_8 = @user_4.orders.create(status: "pending")
      @order_9 = @user_4.orders.create(status: "complete")
      @order_10 = @user_5.orders.create(status: "complete")
      @order_11 = @user_6.orders.create(status: "complete")
      @order_12 = @user_7.orders.create(status: "complete")

      order_item = @order_1.order_items.create(item: @item, item_price: 4.00, item_quantity: 3)
      order_item_2 = @order_1.order_items.create(item: @item, item_price: 4.00, item_quantity: 1)
      order_item_3 = @order_3.order_items.create(item: @item, item_price: 4.00, item_quantity: 3)
      order_item_4 = @order_4.order_items.create(item: @item_2, item_price: 4.00, item_quantity: 2)
      order_item_5 = @order_5.order_items.create(item: @item_2, item_price: 4.00, item_quantity: 5)
    end

    it "count total items in an order" do
      expect(@order_1.item_count).to eq(4)
    end

    it ".top_user_spending" do
      expect(Order.top_user_spending).to eq([@user_4.id, @user.id, @user_2.id])
    end

    it ".top_orders_by_items" do
      expect(Order.top_orders_by_items).to eq([@order_5, @order_1, @order_3])
    end
  end
end
