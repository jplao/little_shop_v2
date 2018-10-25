require 'rails_helper'

describe 'user registration' do
  it 'anonymous visitor' do
    user = build(:user)
    flash = 'You have successfully registered and have been logged in'

    visit root_path

    click_on 'Register'

    expect(current_path).to eq(register_path)
    fill_in :user_name, with: user.name
    fill_in :user_street_address, with: user.street_address
    fill_in :user_city, with: user.city
    fill_in :user_state, with: user.state
    fill_in :user_zip, with: user.zip
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password
    click_on 'Create User'

    expect(current_path).to eq(profile_path)
    expect(page).to have_content(flash)
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.street_address)
    expect(page).to have_content(user.city)
    expect(page).to have_content(user.state)
    expect(page).to have_content(user.zip)
    expect(page).to have_content(user.email)
  end

  it 'anonymous visitor fails registration because it was blank' do
    flash = 'Some fields were missing or incorrectly entered. Please try again.'

    visit register_path
    click_on 'Create User'
    expect(page).to have_content(flash)
    expect(current_path).to eq(register_path)
    expect(page).to have_button('Create User')
  end

end
