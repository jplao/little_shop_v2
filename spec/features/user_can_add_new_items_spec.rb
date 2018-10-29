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

  after(:each) do
    click_link 'Log Out'
  end

  it 'can click link to add new items' do
    visit dashboard_items_path

    click_link 'Add New Item'

    expect(current_path).to eq(new_dashboard_item_path)
  end
end
