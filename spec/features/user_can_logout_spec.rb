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

    visit profile_path

    expect(current_path).to eq(login_path)
    expect(page).to have_content("You are not logged in")
  end

  it 'should empty cart upon logging out' do

    @item_1, @item_2 = create_list(:item, 2)

    visit item_path(@item_1)
    click_on('Add to Cart')
    visit item_path(@item_2)
    click_on('Add to Cart')
    click_on('Add to Cart')

    expect(page).to have_content('Cart (3)')

    click_on('Log Out')

    expect(page).to have_content('Cart (0)')

  end
end
