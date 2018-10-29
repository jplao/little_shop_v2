require 'rails_helper'

describe 'user sees profile page' do
  context 'logged in as any type of user' do
    before(:each) do
      @user = create(:user)
      visit root_path
      click_link "Log In"
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log In"
    end

    it 'displays all profile data' do

      visit profile_path

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.street_address)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zip)
      expect(page).to have_content(@user.email)
      expect(page).to have_link("Edit Profile")
      click_link 'Log Out'
    end

    it "displays profile stats" do
      # TODO Flesh this out

      visit profile_path
      expect(page).to have_content("Statistics")
      click_link 'Log Out'
    end

    it "shows no orders link if user has no orders" do
      visit profile_path

      within(".user_orders") do
        expect(page).not_to have_link("My Orders")
      end
      click_link 'Log Out'
    end

    it "shows orders link if user has orders" do
      order = create(:order, user: @user)
      visit profile_path
      expect(page).to have_link("My Orders")
      click_link 'Log Out'
    end
  end

  it 'as a visitor' do
    visit profile_path

    expect(current_path).to eq(login_path)
    expect(page).to have_content('You are not logged in')
  end

  context 'as an admin' do

    before(:each) do
      @admin = create(:user, role: 2)
      visit root_path
      click_link "Log In"
      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password
      click_button "Log In"

      @user = create(:user)

    end

    it 'the user can be upgraded to a merchant' do

      visit user_path(@user)

      click_button 'Upgrade User'

      expect(current_path).to eq(merchant_path(@user))
      expect(page).to have_content('User has been upgraded to merchant')
    end

    it 'the user is merchant after admin upgrades them' do

      visit user_path(@user)

      click_button 'Upgrade User'
      click_button 'Log Out'

      visit root_path
      click_link "Log In"
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log In"

      expect(page).to have_link("My Dashboard")
      expect(User.find(@user.id).role).to eq(1)
    end
  end



end
