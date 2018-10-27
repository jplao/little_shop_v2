require "rails_helper"

describe 'log out process' do
  before :each do
    @user = create(:user)
    visit root_path
    click_on "Log In"
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Log In"
  end

  it 'should log out user' do
    visit root_path

    click_link 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have successfully logged out")
    #expect(session[:cart].count).to eq(0) build once we have cart functionality

    visit profile_path

    expect(current_path).to eq(login_path)
    expect(page).to have_content("You are not logged in")

  end
end
