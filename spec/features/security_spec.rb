require 'rails_helper'

describe 'as a'do

  before(:each) do
    @admin = create(:user, role: 2)
    @merchant = create(:user, role: 1)
    @user_1, @user_2 = create_list(:user, 2)

    @order_1 = create(:order, user_id: @user_1.id)
    @order_2 = create(:order, user_id: @user_2.id)

  end

  describe 'user who may or may not be merchant' do
    before(:each) do
      visit login_path
      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button 'Log In'
    end

    it 'I can only view my own orders' do
      visit user_orders_path(@user_2)
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You don't have permission for that")
    end

    it 'I can only view my own profile data' do
      visit user_path(@user_2)
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You don't have permission for that")
    end

  end

  describe '  '
end
