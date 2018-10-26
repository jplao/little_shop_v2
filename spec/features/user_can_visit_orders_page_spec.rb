require "rails_helper"

describe "when user visits an order index page" do
  before(:each) do
    @user = create(:user)
    @order = @user.orders.create(status: "pending")
    @order_2 = @user.orders.create(status: "complete")
    @order_3 = @user.orders.create(status: "cancelled")

    @item, @item_2 = create_list(:item, 2)
    order_item = @order.order_items.create(item: @item, item_price: 4.00, item_quantity: 3)
    order_item_2 = @order.order_items.create(item: @item_2, item_price: 2.00, item_quantity: 1)

    visit root_path
    click_link "Log In"

    fill_in :name, with: @user.name
    fill_in :password, with: @user.password

    click_button "Log In"
    end
  it "displays every order registered user has ever made" do

    visit profile_orders_path

    expect(page).to have_link(@order.id)
    expect(page).to have_content(@order.created_at)
    expect(page).to have_content(@order.updated_at)
    expect(page).to have_content(@order.status)
    expect(page).to have_content(@order_2.id)
    expect(page).to have_content(@order_2.created_at)
    expect(page).to have_content(@order_2.updated_at)
    expect(page).to have_content(@order_2.status)
  end
  it "they can click on order id and redirect to the order show page" do

    visit profile_orders_path
    click_link "#{@order.id}"
    expect(current_path).to eq(order_path(@order))
  end
  it "they see total quantity of items in the order" do
    visit profile_orders_path

    expect(page).to have_content("Number of Items: 4")
  end
  it "they see grand total price of order" do
    visit profile_orders_path

    expect(page).to have_content("Grand Total: $14.00")
  end
  it "they see an option to cancel a pending order" do
    visit profile_orders_path

    within("#order#{@order.id}") do
      expect(page).to have_link("Cancel Order")
    end
    within("#order#{@order_2.id}") do
      expect(page).not_to have_link("Cancel Order")
    end
  end
  it "they can cancel an order" do
    visit profile_orders_path

    within("#order#{@order.id}") do
      click_on "Cancel Order"
    end

    expect(current_path).to eq(profile_orders_path)
    within("#order#{@order.id}") do
      expect(page).to have_content("cancelled")
    end
  end
end
