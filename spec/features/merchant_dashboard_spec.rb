require 'rails_helper'

describe 'Merchant dashboard' do

  before(:each) do
    merchant = create(:user, role: 1)
    customer = create(:user)
    item = create(:item)
    order = create(:order)
    merchant.items = [item]
    order.order_items.create(item: item, item_price: 1.99, item_quantity: 1)
    customer.orders = [order]

    visit root_path
    click_link "Log In"
    fill_in :email, with: merchant.email
    fill_in :password, with: customer.password
    click_button "Log In"
  end

  it 'shows a link to orders when a merchant has orders' do
    visit dashboard_path
    expect(page).to have_link("Orders")
  end

end
