require 'rails_helper'
describe 'when a user visits profile edit page' do
  before(:each) do
    @user = create(:user)

    visit root_path
    click_on "Log In"
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Log In"
  end

  it 'user can make changes to their profile' do
    visit profile_path

    click_on "Edit Profile"

    expect(current_path).to eq(profile_edit_path)

    name = "New Name"
    city = "New City"
    email = "NewEmail@mail.com"
    fill_in :profile_name, with: name
    fill_in :profile_city, with: city
    fill_in :profile_email, with: email
    fill_in :profile_password, with: @user.password
    click_on "Edit User"

    expect(current_path).to eq(profile_path)
    expect(page).to have_content("Your Data Has Been Updated")
    expect(page).to have_content(name)
    expect(page).to have_content(city)
    expect(page).to have_content(email)
    expect(page).to have_content(@user.zip)
    click_link 'Log Out'
  end

  it 'user cant make changes to their profile without password' do
    user = create(:user)
    visit profile_path

    click_on "Edit Profile"

    expect(current_path).to eq(profile_edit_path)

    name = "New Name"
    city = "New City"
    email = "NewEmail@mail.com"
    fill_in :profile_name, with: name
    fill_in :profile_city, with: city
    fill_in :profile_email, with: email
    click_on "Edit User"

    expect(current_path).to eq(profile_edit_path)
    expect(page).to have_content("Please Enter Password Before Making Changes")
    click_link 'Log Out'
  end

  it 'user cant make changes to their profile without correct password' do
    user = create(:user)
    visit profile_path

    click_on "Edit Profile"

    expect(current_path).to eq(profile_edit_path)

    name = "New Name"
    city = "New City"
    email = "NewEmail@mail.com"
    fill_in :profile_name, with: name
    fill_in :profile_city, with: city
    fill_in :profile_email, with: email
    fill_in :profile_password, with: "Wrong password"
    click_on "Edit User"

    expect(current_path).to eq(profile_edit_path)
    expect(page).to have_content("Please Enter CORRECT Password Before Making Changes")
    click_link 'Log Out'
  end

  it 'user cant update their email to one that one that already exists' do
    user_2 = create(:user)
    original_email = @user.email

    visit profile_path
    click_on "Edit Profile"

    fill_in :profile_email, with: user_2.email
    fill_in :profile_password, with: @user.password
    click_on "Edit User"
    expect(current_path).to eq(profile_edit_path)
    expect(page).to have_content("That Email Is Already in Use")
    expect(@user.email).to eq(original_email)
    click_link 'Log Out'
  end
end
