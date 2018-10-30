require 'rails_helper'

describe 'as a merchant' do
  before(:each) do
    @merchant = create(:user, role: 1)
    @item = create(:item)
    @merchant.items = [@item]
    visit root_path
    click_on "Log In"
    fill_in :email, with: @merchant.email
    fill_in :password, with: @merchant.password
    click_button 'Log In'

  end

  it 'user can update information of an existing item' do
    new_name = "New_Item"
    new_price = 20
    new_count = 50

    visit dashboard_items_path
    click_on 'Edit Item'
    expect(current_path).to eq(edit_item_path(@item))

    fill_in :item_name, with: new_name
    fill_in :item_price, with: new_price
    fill_in :item_inventory_count, with: new_count
    click_on 'Update Item'

    expect(current_path).to eq(dashboard_items_path)

    expect(page).to have_content("Item Has Been Updated")
    expect(page).to have_content(new_name)
    expect(page).to have_content("Price: #{new_price}")
    expect(page).to have_content("Inventory Count: #{new_count}")
  end

  it 'information not in update included wont be updated' do
    new_name = "New_Item"

    visit dashboard_items_path
    click_on 'Edit Item'
    expect(current_path).to eq(edit_item_path(@item))

    fill_in :item_name, with: new_name
    click_on 'Update Item'

    expect(current_path).to eq(dashboard_items_path)

    expect(page).to have_content("Item Has Been Updated")
    expect(page).to have_content(new_name)
    expect(page).to have_content("Price: #{@item.price}")
    expect(page).to have_content("Inventory Count: #{@item.inventory_count}")
  end
end
