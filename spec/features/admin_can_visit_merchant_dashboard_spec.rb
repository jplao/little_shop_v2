require 'rails_helper'

RSpec.describe 'visiting merchant dashboard' do
  context 'as an admin' do

    before :each do
      @admin = create(:user, role: 2, password: "admin", email: "admin")
      @merchant = create(:user, role: 1)
      @customer_1, @customer_2 = create_list(:user, 2)

      @item_1, @item_2, @item_3 = create_list(:item, 3)
      @order_1, @order_2, @order_3 = create_list(:order, 3)
      @merchant.items = [@item_1, @item_2]
      @oi = @order_1.order_items.create(item: @item_1, item_price: 1.99, item_quantity: 10)
      @oi_2 = @order_2.order_items.create(item: @item_2, item_price: 3.99, item_quantity: 5)
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

    it "regular users cannot use merchant_path show page uri" do
      click_link "Log Out"
      visit root_path
      click_link "Log In"
      fill_in :email, with: @customer_1.email
      fill_in :password, with: @customer_1.password
      click_button "Log In"

      visit merchant_path(@customer_1)

      expect(current_path).to eq(user_path(@customer_1))
    end

    it "admin sees profile page on merchant dashboard" do

      visit merchant_path(@merchant)

      expect(page).to have_content(@merchant.name)
      expect(page).to have_content(@merchant.street_address)
      expect(page).to have_content(@merchant.city)
      expect(page).to have_content(@merchant.state)
      expect(page).to have_content(@merchant.zip)
      expect(page).to have_content(@merchant.email)
    end

    it 'sees link to the merchant\'s items' do

      visit merchant_path(@merchant)

      click_on "Merchant Items"

      expect(current_path).to eq(merchant_items_path(@merchant))
    end

    it 'sees all of merchants items' do

      visit merchant_items_path(@merchant)

      within "#item#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@item_1.inventory_count)
      end

      within "#item#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@item_2.inventory_count)
      end

      expect(page).to_not have_content(@item_3.name)

    end

    it 'can add an item to merchant' do

      visit merchant_items_path(@merchant)
      click_on "Add New Item"
      expect(current_path).to eq(new_merchant_item_path(@merchant))

      fill_in :item_name, with: @item_1.name
      fill_in :item_description, with: @item_1.description
      fill_in :item_image, with: @item_1.image
      fill_in :item_price, with: @item_1.price
      fill_in :item_inventory_count, with: @item_1.inventory_count

      click_button 'Create Item'

      expect(current_path).to eq(merchant_items_path(@merchant))
      expect(page).to have_content("You have successfully added a new item")
    end

    it 'can edit a merchants item' do
      new_item = create(:item)
      visit merchant_items_path(@merchant)

      within "#item#{@item_1.id}" do
        click_on "Edit Item"
      end

      expect(current_path).to eq(edit_item_path(@item_1))

      fill_in :item_name, with: new_item.name
      fill_in :item_price, with: new_item.price
      fill_in :item_inventory_count, with: new_item.inventory_count

      click_button 'Update Item'

      expect(current_path).to eq(merchant_items_path(@merchant))
      # expect(page).to have_content("Item Has Been Updated")

      within "#item#{@item_1.id}" do
        expect(page).to have_content(new_item.name)
        expect(page).to have_content(new_item.price)
        expect(page).to have_content(new_item.inventory_count)
      end
    end

    it 'can edit only a part of a merchants item ' do
      new_item = create(:item)
      visit merchant_items_path(@merchant)

      within "#item#{@item_1.id}" do
        click_on "Edit Item"
      end

      expect(current_path).to eq(edit_item_path(@item_1))

      fill_in :item_price, with: new_item.price
      fill_in :item_inventory_count, with: new_item.inventory_count

      click_button 'Update Item'

      expect(current_path).to eq(merchant_items_path(@merchant))
      # expect(page).to have_content("Item Has Been Updated")

      within "#item#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(new_item.price)
        expect(page).to have_content(new_item.inventory_count)
      end
    end

    it 'can diasable a merchants item' do
      visit merchant_items_path(@merchant)

      within("#item#{@item_1.id}") do
        click_button "Disable"
      end

      expect(current_path).to eq(merchant_items_path(@merchant))
      expect(page).to have_content("Item ##{@item_1.id} no longer for sale")

      within("#item#{@item_1.id}") do
        expect(page).to have_button("Enable")
      end
    end

    it 'can enable a merchants item' do
      visit merchant_items_path(@merchant)

      within("#item#{@item_1.id}") do
        click_button "Disable"
      end

      within("#item#{@item_1.id}") do
        click_button "Enable"
      end

      expect(current_path).to eq(merchant_items_path(@merchant))
      expect(page).to have_content("Item ##{@item_1.id} now available for sale")

      within("#item#{@item_1.id}") do
        expect(page).to have_button("Disable")
      end
    end

  end
end
