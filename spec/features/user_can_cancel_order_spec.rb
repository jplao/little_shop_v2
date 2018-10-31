require 'rails_helper'
describe 'order cancallation' do
  after (:each) do
    click_on 'Log Out'
  end

  describe 'as a user' do
    before (:each) do
      @order_item = create(:order_item)
      @order = @order_item.order
      @buyer = @order_item.order.user
      @seller = @order_item.item.user
      @item = @order_item.item

      visit login_path
      fill_in :email, with: @buyer.email
      fill_in :password, with: @buyer.password
      click_button 'Log In'
      visit profile_orders_path
    end

    it 'can cancel an order' do
      click_on 'Cancel Order'
      expect(page).to have_content('Current Status: cancelled')
      expect(Order.find(@order.id).status).to eq('cancelled')
    end
  end

  describe 'as an admin' do

    before (:each) do
      @order_item = create(:order_item)
      @order = @order_item.order
      @buyer = @order_item.order.user
      @seller = @order_item.item.user
      @item = @order_item.item
      @admin = create(:user, role: 2)

      visit login_path
      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password
      click_button 'Log In'
      visit user_orders_path(@buyer)
    end

    it 'can cancel an order' do
      click_on 'Cancel Order'
      expect(page).to have_content('Current Status: cancelled')
      expect(Order.find(@order.id).status).to eq('cancelled')
    end

end


end
