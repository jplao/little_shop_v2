require "rails_helper"

describe 'log out process' do
  before :each do
    visit root_path
    click_on "Log In"
    fill_in :name, with: @user.name
    fill_in :password, with: @user.password
    click_on "Log In"
  end

  it 'should log out user' do
    visit profile_path

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have successfully logged out")
    #expect(session[:cart].count).to eq(0) build once we have cart functionality

  end
end
