require 'rails_helper'

describe Order, type: :model do

  describe 'Relationships' do
    it {should belong_to :user}
    it {should have_many :order_items}
    it {should have_many(:items).through(:order_items)}
  end
  describe "instance methods" do
    before(:each) do
      @user = create(:user, city: "Denver")
      @user_2 = create(:user, city: "San Francisco")
      @user_3 = create(:user, city: "Chattanooga")
      @merchant = create(:user, role: 1)
      @item, @item_2 = create_list(:item, 2, user: @merchant)

      @order_1 = @user.orders.create(status: "complete")
      @order_2 = @user.orders.create(status: "complete")
      @order_3 = @user_2.orders.create(status: "complete")
      @order_4 = @user_3.orders.create(status: "complete")
      @order_5 = @user_3.orders.create(status: "complete")
      @order_6 = @user_3.orders.create(status: "complete")
      @order_7 = @user.orders.create(status: "pending")
      @order_8 = @user.orders.create(status: "pending")
      @order_9 = @user.orders.create(status: "pending")

      order_item = @order_1.order_items.create(item: @item, item_price: 4.00, item_quantity: 3)
      order_item_2 = @order_1.order_items.create(item: @item, item_price: 4.00, item_quantity: 1)
    end

    it "count total items in an order" do
      expect(@order_1.item_count).to eq(4)
    end

    it "returns top three states where orders were shipped" do
      expect(Order.top_three_cities).to eq(["Chattanooga", "Denver", "San Francisco"])
    end
  end
end
