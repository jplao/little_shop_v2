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

  it 'shows enabled and disabled merchants' do
    admin = create(:user, role:2)
    visit login_path

    fill_in :email, with: admin.email
    fill_in :password, with: admin.password

    click_button 'Log In'

    merchant_1 = create(:user, role:1)
    merchant_2 = create(:user, role:1, active:false)

    visit merchants_path

    within("#user#{merchant_1.id}") do
      expect(page).to have_button('Disable')
    end

    within("#user#{merchant_2.id}") do
      expect(page).to have_button('Enable')
    end
    click_link 'Log Out'
  end

  it 'as a admin can disable merchants' do
    admin = create(:user, role:2)
    visit login_path

    fill_in :email, with: admin.email
    fill_in :password, with: admin.password

    click_button 'Log In'

    merchant_1, merchant_2, merchant_3, merchant_4 = create_list(:user, 4, role:1)

    visit merchants_path

    within("#user#{merchant_1.id}") do
      expect(page).to have_button('Disable')
      click_on 'Disable'
    end

    within("#user#{merchant_1.id}") do
      expect(page).to have_button("Enable")
    end
    click_link 'Log Out'
  end
end
