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

    fill_in :email, with: @user.email
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
    click_link 'Log Out'
  end

  it "they can click on order id and redirect to the order show page" do
    visit profile_orders_path
    click_link "#{@order.id}"

    expect(current_path).to eq(order_path(@order))
    click_link 'Log Out'
  end

  it "they see total quantity of items in the order" do
    visit profile_orders_path

    expect(page).to have_content("Number of Items: 4")
    click_link 'Log Out'
  end

  it "they see grand total price of order" do
    visit profile_orders_path

    expect(page).to have_content("Grand Total: $14.00")
    click_link 'Log Out'
  end

  it "they see an option to cancel a pending order" do
    visit profile_orders_path

    within("#order#{@order.id}") do
      expect(page).to have_link("Cancel Order")
    end

    within("#order#{@order_2.id}") do
      expect(page).not_to have_link("Cancel Order")
    end

    click_link 'Log Out'
  end

  it "they can cancel an order as a registered user" do
    visit profile_orders_path

    within("#order#{@order.id}") do
      click_on "Cancel Order"
    end

    expect(current_path).to eq(profile_orders_path)
    within("#order#{@order.id}") do
      expect(page).to have_content("cancelled")
    end
    click_link 'Log Out'
  end

  it "an admin can see all users orders and cancel them if pending" do
    @admin = create(:user, role: 2)
    @user_5 = create(:user)
    @order_5 = @user_5.orders.create(status: "pending")
    @item_5, @item_6 = create_list(:item, 2)
    order_item_5 = @order_5.order_items.create(item: @item_5, item_price: 6.00, item_quantity: 22)
    @order_5.order_items.create(item: @item_6, item_price: 3.00, item_quantity: 13)

    visit root_path
    click_link "Log Out"
    click_link "Log In"

    fill_in :email, with: @admin.email
    fill_in :password, with: @admin.password
    click_button "Log In"

    click_link "All Orders"

    expect(current_path).to eq(orders_path)

    expect(page).to have_content(@user.orders.first.id)
    expect(page).to have_content(@user_5.orders.first.id)

    within("#order#{@order_5.id}") do
      click_on "Cancel Order"
    end

    expect(current_path).to eq(orders_path)
    within("#order#{@order_5.id}") do
      expect(page).to have_content("cancelled")
    end
    click_link 'Log Out'
  end

  it "an admin can see an indvidual users orders" do
    @admin = create(:user, role: 2)
    @user_5 = create(:user)
    @order_5 = @user_5.orders.create(status: "pending", id: 100000)
    @item_5, @item_6 = create_list(:item, 2)
    order_item_5 = @order_5.order_items.create(item: @item_5, item_price: 6.00, item_quantity: 22)
    @order_5.order_items.create(item: @item_6, item_price: 3.00, item_quantity: 13)

    visit root_path
    click_link "Log Out"
    click_link "Log In"

    fill_in :email, with: @admin.email
    fill_in :password, with: @admin.password
    click_button "Log In"

    visit user_path(@user)

    within(".user_orders") do
      click_link("My Orders")
    end

    expect(current_path).to eq(user_orders_path(@user))
    expect(page).to have_content(@order.id)
    expect(page).to have_content(@order_2.id)
    expect(page).to have_content(@order_3.id)
    expect(page).not_to have_content(@order_5.id)
  end
  it "visitor cannot visit the orders index page" do
    click_on "Log Out"

    visit orders_path

    expect(current_path).to eq(login_path)
    expect(page).to have_content("You are not logged in")
  end
end
