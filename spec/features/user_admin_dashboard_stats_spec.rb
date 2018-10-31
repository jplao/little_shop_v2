require "rails_helper"

describe "when an admin visits dashboard page" do
  it "it displays top statistics" do
    @admin = create(:user, role: 2, password: "admin", email: "admin")
    @user = create(:user, state: "CO", city: "Denver")
    @user_2 = create(:user, state: "CA", city: "San Fran")
    @user_3 = create(:user, state: "TN", city: "Chattanooga")
    @user_4 = create(:user, state: "TN", city: "Knoxville")
    @user_5 = create(:user, state: "TN", city: "Nashville")
    @user_6 = create(:user, state: "CO", city: "Boulder")
    @user_7 = create(:user, state: "CO", city: "Ft Collins")
    @user_8 = create(:user, state: "CA", city: "San Diego")
    @user_9 = create(:user, state: "KY", city: "Louisville")

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

    visit root_path
    click_link "Log In"
    fill_in :email, with: @admin.email
    fill_in :password, with: @admin.password
    click_button "Log In"

    click_link "My Dashboard"

    within(".top-states") do
      expect(page).to have_content("CO")
      expect(page).to have_content("CA")
      expect(page).to have_content("TN")
    end

    within(".top-spenders") do
      expect(page).to have_content(@user_4.name)
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user_2.name)
    end

    within(".top-orders-by-item-count") do
      expect(page).to have_content(@order_5.id)
      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_3.id)
    end
  end
end
