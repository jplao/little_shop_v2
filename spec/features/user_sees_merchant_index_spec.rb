require 'rails_helper'

describe 'when any user visits the merchant index page' do
  it 'they see a list of all merchants' do
    merchant_1, merchant_2, merchant_3, merchant_4 = create_list(:user, 4, role:1)
    user_1 = create(:user)

    visit root_path

    click_link 'All Merchants'

    expect(current_path).to eq(merchants_path)
    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
    expect(page).to have_content(merchant_3.name)
    expect(page).to have_content(merchant_4.name)
    expect(page).not_to have_content(user_1.name)
  end

  it 'as a admin can disable merchants' do
    merchant_1, merchant_2, merchant_3, merchant_4 = create_list(:user, 4, role:1)
    merchant_5 = create(:user, role:1, active:false)

    visit merchants_path

    within("#user#{merchant_1.id}") do
      expect(page).to have_button('Disable')
      save_and_open_page
      
      click_on 'Disable'

      expect(page).to have_button("Enable")
    end
  end
end
