require 'rails_helper'

RSpec.describe 'visiting merchant dashboard' do
  context 'as an admin' do

    before :each do
      @admin = create(:user, role: 2, password: "admin", email: "admin")
      @merchant = create(:user, role: 1)
      @customer_1, @customer_2 = create_list(:user, 2)

      @item_1, @item_2 = create_list(:item, 2)
      @order_1, @order_2, @order_3 = create_list(:order, 3)
      @merchant.items = [@item_1, @item_2]
      @order_1.order_items.create(item: @item_1, item_price: 1.99, item_quantity: 10)
      @order_2.order_items.create(item: @item_2, item_price: 3.99, item_quantity: 5)
      @customer_1.orders = [@order_1, @order_2]
      @customer_2.orders = [@order_3]


      visit root_path
      click_link "Log In"
      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password
      click_button "Log In"
    end

    it 'displays merchant functionality' do
      visit root_path
      click_link "All Merchants"
      click_link @merchant.name

      expect(current_path).to eq(merchant_path(@merchant))

      click_link "Edit Merchant Profile"

      fill_in :profile_name, with: "New Name"
      fill_in :profile_city, with: "New City"
      fill_in :profile_email, with: "New Email"
      fill_in :profile_password, with: "#{@merchant.password}"
      click_button "Edit User"

      expect(current_path).to eq(merchant_path(@merchant))

      click_link("All Merchants")

      within "#user#{@merchant.id}" do
        expect(page).to have_content(User.find(@merchant.id).name)
      end
    end

    it 'can click link to view merchant orders' do

      visit merchant_path(@merchant)

      click_link "Merchant Orders"
      expect(current_path).to eq(merchant_orders_path(@merchant))

      within "#order#{@order_1.id}" do
        expect(page).to have_content(@order_1.id)
        expect(page).to have_content(@order_1.item_count)
      end

      within "#order#{@order_2.id}" do
        expect(page).to have_content(@order_2.id)
        expect(page).to have_content(@order_2.item_count)
      end

      expect(page).to_not have_content("Number of Items: #{@order_3.item_count}")
    end
  end
end
