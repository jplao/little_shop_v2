require 'rails_helper'

describe 'Merchant dashboard' do

  context 'as a merchant' do
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

    it 'shows a link to orders when a merchant has orders' do
      visit dashboard_path
      within(".dashboard_orders") do
        expect(page).to have_link("Orders")
      end
      click_link 'Log Out'
    end

    it 'on orders page shows all orders' do

      visit dashboard_path
      within(".dashboard_orders") do
        click_link "Orders"
      end

      expect(current_path).to eq(dashboard_orders_path)
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

    it 'on orders page does not show orders of another merchant' do
      @merchant_2 = create(:user, role: 1)
      @item_4 = create(:item)
      @merchant_2.items = [@item_4]
      @order_4 = create(:order)
      @order_4.order_items.create(item: @item_4, item_price: 7.99, item_quantity: 4)

      visit dashboard_path
      within(".dashboard_orders") do
        click_link "Orders"
      end

      expect(current_path).to eq(dashboard_orders_path)

      expect(current_path).to eq(dashboard_orders_path)
      expect(page).not_to have_link(@order_4.id)
      click_link 'Log Out'
    end

    it 'doesnt show a link to orders when a merchant has no orders' do
      click_link 'Log Out'
      merchant = create(:user, role: 1)
      visit root_path
      click_link "Log In"
      fill_in :email, with: merchant.email
      fill_in :password, with: merchant.password
      click_button "Log In"

      visit dashboard_path

      within(".dashboard_orders") do
        expect(page).to_not have_link("Orders")
      end
      click_link 'Log Out'
    end

    it 'as a registered user cannot visit dashboard page' do
      user = create(:user)
      click_link 'Log Out'
      visit root_path
      click_link "Log In"
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button "Log In"

      visit dashboard_path

      expect(current_path).to eq(root_path)
    end

    it 'shows a link to items sold when a merchant' do
      visit dashboard_path
      within(".dashboard_items") do
        expect(page).to have_link("My Items")
      end
      click_link 'Log Out'
    end
  end

  context 'as an admin' do

    before(:each) do
      @admin = create(:user, role: 2)
      visit root_path
      click_link "Log In"
      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password
      click_button "Log In"

      @merchant = create(:user, role: 1)

    end

    it 'the merchant can be downgraded to a user' do

      visit merchant_path(@merchant)

      click_button 'Downgrade User'

      expect(current_path).to eq(user_path(@merchant))
      expect(page).to have_content('Merchant has been downgraded to user')
    end

    it 'the merchant is a user after admin downgrades them' do

      visit merchant_path(@merchant)

      click_button 'Downgrade User'
      click_link 'Log Out'

      visit root_path
      click_link "Log In"
      fill_in :email, with: @merchant.email
      fill_in :password, with: @merchant.password
      click_button "Log In"

      expect(page).to_not have_link("My Dashboard")
      expect(User.find(@merchant.id).role).to eq('user')
    end
  end
end
