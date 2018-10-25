require 'rails_helper'

describe 'Navigation' do

  context 'as a visitor' do

    it 'I see links in my nav bar' do
      visit root_path

      expect(page).to have_link('Home')
      expect(page).to have_link('All Items')
      expect(page).to have_link('All Merchants')
      expect(page).to have_link('Shopping Cart')
      expect(page).to have_link('Login')
      expect(page).to have_link('Register')

    end

  end

  context 'as a registered user' do

  end

  context 'as a merchant' do

  end

  context 'as an admin' do

  end

end
