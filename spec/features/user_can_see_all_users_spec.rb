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
      click_link 'Log Out'
    end

    it 'can see all users show page' do
      @admin = create(:user, role: 2)
      visit root_path
      click_link "Log In"
      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password
      click_button "Log In"

      click_link "All Users"
      click_link "#{@user_1.name}"

      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1.street_address)
      expect(page).to have_content(@user_1.city)
      expect(page).to have_content(@user_1.state)
      expect(page).to have_content(@user_1.zip)
      expect(page).to have_content(@user_1.email)
      expect(page).to have_link("Edit Profile")
      click_link 'Log Out'
    end
  end

  it 'as a regular user cannot visit other users porfile pages' do
    user = create(:user)
    user_2 = create(:user)
    visit root_path
    click_link "Log In"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log In"

    visit user_path(user_2)

    expect(current_path).not_to have_content(user_2.name)
  end
end
