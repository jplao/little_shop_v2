require "rails_helper"

describe "when a merchant visits the orders page from the dashbaord" do
  before(:each) do
    @merchant = create(:user, role: 1)
    @customer = create(:user)
    @item = create(:item)
    @order, @order_2 = create_list(:order, 2)
    @merchant.items = [@item]
    @order.order_items.create(item: @item, item_price: 1.99, item_quantity: 10)
    @order_2.order_items.create(item: @item, item_price: 3.99, item_quantity: 5)
    @customer.orders = [@order, @order_2]
    visit root_path
    click_link "Log In"
    fill_in :email, with: @merchant.email
    fill_in :password, with: @merchant.password
    click_button "Log In"
  end
  it "they can click an order id to visit order show page" do
    visit dashboard_orders_path

    click_link("#{@order.id}")

    expect(current_path).to eq(order_path(@order))
  end
end
