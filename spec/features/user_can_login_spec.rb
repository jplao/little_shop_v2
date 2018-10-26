require 'rails_helper'

describe 'log in process' do
  before :each do
    @user = create(:user)
  end

  it 'should succeed if credentials are correct' do
    visit root_path

    click_on 'Log In'
    expect(current_path).to eq(login_path)

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on 'Log In'
    expect(current_path).to eq(profile_path)
    expect(page).to have_content("You have successfully logged in")
  end

  it 'should fail if password is incorrect' do
    visit root_path

    click_on 'Log In'
    expect(current_path).to eq(login_path)

    fill_in :email, with: @user.email
    fill_in :password, with: 'badpassword'

    click_on 'Log In'
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Password does not match username. Please try again.")
    expect(page).to have_button("Log In")
  end

  it 'should fail if credentials are empty' do
    visit root_path

    click_on 'Log In'
    expect(current_path).to eq(login_path)

    click_on 'Log In'
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Could not log in. Please try again.")
    expect(page).to have_button("Log In")
  end

  it 'should redirect if already logged in' do
    visit root_path
    click_on "Log In"
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on "Log In"

    expect(current_path).to eq(profile_path)

    visit login_path

    expect(current_path).to eq(profile_path)
    expect(page).to have_content("You are already logged in")
  end
end
