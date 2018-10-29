require "rails_helper"

describe "when a merchant visits the orders page from the dashbaord" do
  before(:each) do
    @merchant = create(:user, role: 1)
    @merchant_2 = create(:user, role: 1)
    @customer = create(:user)
    @item = create(:item)
    @item_2 = create(:item)
    @order, @order_2 = create_list(:order, 2)
    @merchant.items = [@item]
    @merchant_2.items = [@item_2]
    @order_item = @order.order_items.create(item: @item, item_price: 1.99, item_quantity: 10)
    @order_item_2 = @order.order_items.create(item: @item_2, item_price: 2.54, item_quantity: 15)
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
  it "they can see see all order info on the show page" do

    visit dashboard_orders_path
    click_link("#{@order.id}")

    expect(page).to have_content(@order.user.name)
    expect(page).to have_content(@order.user.street_address)

    expect(page).to have_link(@item.name)
    expect(page).to have_css("img[src='#{@item.image}']")
    expect(page).to have_content("$1.99")
    expect(page).to have_content(@order_item.item_quantity)
    expect(page).not_to have_link(@item_2.name)
    expect(page).not_to have_content("$2.54")

    click_link("#{@item.name}")
    expect(current_path).to eq(item_path(@item))
  end
end
