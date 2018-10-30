require 'rails_helper'

describe 'Merchant dashboard items' do
  before(:each) do
    @merchant = create(:user, role: 1)
    @item, @item_2, @item_3 = create_list(:item, 3)
    @item_4 = create(:item, active: false)
    @merchant.items = [@item, @item_2, @item_3, @item_4]

    visit root_path
    click_link "Log In"
    fill_in :email, with: @merchant.email
    fill_in :password, with: @merchant.password
    click_button "Log In"
  end

  it 'shows all items sold by merchant' do
    visit dashboard_items_path

    within(".add_item") do
      expect(page).to have_link('Add New Item')
    end

    within("#item#{@item.id}") do
      expect(page).to have_content(@item.id)
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.inventory_count)
      expect(page).to have_link('Edit Item')
      expect(page).to have_button('Disable')
    end

    within("#item#{@item_2.id}") do
      expect(page).to have_content(@item_2.id)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_2.price)
      expect(page).to have_content(@item_2.inventory_count)
      expect(page).to have_link('Edit Item')
      expect(page).to have_button('Disable')
    end

    within("#item#{@item_3.id}") do
      expect(page).to have_content(@item_3.id)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_3.price)
      expect(page).to have_content(@item_3.inventory_count)
      expect(page).to have_link('Edit Item')
      expect(page).to have_button('Disable')
    end

    within("#item#{@item_4.id}") do
      expect(page).to have_content(@item_4.id)
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_4.price)
      expect(page).to have_content(@item_4.inventory_count)
      expect(page).to have_link('Edit Item')
      expect(page).to have_button('Enable')
    end
    click_link "Log Out"
  end

    it 'a merchant can disable an item' do
      visit dashboard_items_path
      within("#item#{@item.id}") do
        click_button "Disable"
      end

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Item ##{@item.id} no longer for sale")

      within("#item#{@item.id}") do
        expect(page).to have_button("Enable")
      end
    end

    it 'a merchant can enable an item' do
      visit dashboard_items_path
      within("#item#{@item_4.id}") do
        click_button "Enable"
      end

      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Item ##{@item_4.id} now available for sale")

      within("#item#{@item_4.id}") do
        expect(page).to have_button("Disable")
      end
    end

  it 'does not show items sold by other merchants' do
    merchant_2 = create(:user, role: 1)
    item_5 = create(:item, user: merchant_2, inventory_count: 100, id: 1000000)

    visit dashboard_items_path
    expect(page).not_to have_content(item_5.id)
    expect(page).not_to have_content(item_5.name)
    expect(page).not_to have_content(item_5.price)
    expect(page).not_to have_content("Inventory Count: #{item_5.inventory_count}")
    click_link "Log Out"
  end
end
