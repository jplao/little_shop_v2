require "rails_helper"

describe 'user can visit the all users page' do
  before(:each) do
    @user_1, @user_2, @user_3 = create_list(:user, 3)
    @merchant_1, @merchant_2, @merchant_3 = create_list(:user, 3, role: 1)
  end
  context 'as an admin' do
    it 'can see all users index that lists all registered users' do
      @admin = create(:user, role: 2)
      visit root_path
      click_link "Log In"
      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password
      click_button "Log In"

      click_link "All Users"

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_2.name)
      expect(page).to have_content(@user_3.name)
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      within(".user-index-header") do
        expect(page).to have_content("All Users")
        expect(page).not_to have_content("All Merchants")
      end
    end
  end
end
