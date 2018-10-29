require 'rails_helper'

describe 'as a merchant' do
  before(:each) do
    @merchant = create(:user, role: 1)
    visit root_path
    click_link 'Log In'
    fill_in :email, with: @merchant.email
    fill_in :password, with: @merchant.password
    click_button 'Log In'
  end

  it 'can click link to add new items' do
    visit dashboard_items_path

    click_link 'Add New Item'

    expect(current_path).to eq(new_dashboard_item_path)
    click_link 'Log Out'
  end

  it 'can add a new item' do
    visit new_dashboard_item_path

    fill_in :item_name, with: 'New Item'
    fill_in :item_description, with: 'New item description'
    fill_in :item_image, with: "https://i.etsystatic.com/12134599/r/il/33b06c/1109211976/il_570xN.1109211976_re7r.jpg"
    fill_in :item_price, with: 999
    fill_in :item_inventory_count, with: 888

    click_button 'Create Item'
  end
end
