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

  it 'anonymous visitor with email that already exists' do
    user_1 = create(:user)
    user_2 = build(:user)
    flash = 'That email is already in use. Try again'

    visit root_path

    click_on 'Register'

    expect(current_path).to eq(register_path)
    fill_in :user_name, with: user_2.name
    fill_in :user_street_address, with: user_2.street_address
    fill_in :user_city, with: user_2.city
    fill_in :user_state, with: user_2.state
    fill_in :user_zip, with: user_2.zip
    fill_in :user_email, with: user_1.email
    fill_in :user_password, with: user_2.password
    fill_in :user_password_confirmation, with: user_2.password
    click_on 'Create User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content(flash)
    expect(user_2.id).to be_nil # because it wasn't created
  end



end
