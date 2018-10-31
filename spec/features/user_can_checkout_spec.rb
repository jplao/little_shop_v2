require 'rails_helper'

describe 'checkout process' do
  before(:each) do
    @user = create(:user)
    @item = create(:item, price: 5.00)
    visit login_path
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button 'Log In'
  end

  it 'lets user add items and checkout' do
    visit item_path(@item)
    click_on 'Add to Cart'

    click_on 'Shopping Cart'
    click_on 'Checkout'
    expect(current_path).to eq(profile_orders_path)
    expect(page).to have_content(Order.last.id)
    expect(page).to have_content('pending')
    expect(page).to have_content('$5.00')
  end
end
