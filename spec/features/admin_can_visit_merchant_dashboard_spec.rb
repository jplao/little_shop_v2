require 'rails_helper'

RSpec.describe 'visiting merchant dashboard' do
  context 'as an admin' do

    before :each do
      @admin = create(:user, role: 2, password: "admin", email: "admin")
      @merchant = create(:user, role: 1)
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

      click_button "Edit Merchant Profile"

      fill_in :profile_name, with: "New Name"
      fill_in :profile_city, with: "New City"
      fill_in :profile_email, with: "New Email"
      fill_in :profile_password, with: "#{@merchant.password}"
      click_button "Edit User"

      expect(current_path).to eq(merchant_path(@merchant))
      expect(page).to have_content("New Name")
      expect(page).to have_content("New City")
      expect(page).to have_content("New Email")

    end
  end
end
