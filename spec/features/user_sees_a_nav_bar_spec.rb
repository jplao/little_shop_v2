require 'rails_helper'

describe 'Navigation' do

  context 'as a visitor' do

    it 'I see links in my nav bar' do
      visit root_path

      expect(page).to have_link('Home')
      expect(page).to have_link('All Items')
      expect(page).to have_link('All Merchants')
      expect(page).to have_link('Shopping Cart')
      expect(page).to have_link('Log In')
      expect(page).to have_link('Register')
      expect(page).not_to have_link('My Dashboard')
    end

  end

  context 'as a registered user' do

  end

  context 'as a merchant' do
    it 'can see all visitor links plus link to dashboard' do
      @merchant = create(:user, role: 1)
      visit root_path
      click_link "Log In"
      fill_in :email, with: @merchant.email
      fill_in :password, with: @merchant.password
      click_button "Log In"

      expect(page).to have_link('My Dashboard')
    end
  end

  context 'as an admin' do

  end

end
