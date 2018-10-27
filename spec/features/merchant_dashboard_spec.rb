require 'rails_helper'

describe 'Merchant dashboard' do

  it 'shows a link to orders when a merchant has orders' do
    merchant = create(:user, role: 1)
    customer = create(:user)
    item = create(:item)
    order = create(:order)
    merchant.items = [item]
    order.order_items.create(item: item, item_price: 1.99, item_quantity: 10)
    customer.orders = [order]
    visit root_path
    click_link "Log In"
    fill_in :email, with: merchant.email
    fill_in :password, with: merchant.password
    click_button "Log In"

    visit dashboard_path
    expect(page).to have_link("Orders")
  end

  it 'doesnt show a link to orders when a merchant has no orders' do
    merchant = create(:user, role: 1)
    visit root_path
    click_link "Log In"
    fill_in :email, with: merchant.email
    fill_in :password, with: merchant.password
    click_button "Log In"

    visit dashboard_path
    expect(page).to_not have_link("Orders")
  end

end
