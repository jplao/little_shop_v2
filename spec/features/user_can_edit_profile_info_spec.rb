require 'rails_helper'

describe 'when a user visits profile edit page' do

  it 'user can make changes to their profile' do
    user = create(:user)
    visit "/profile/#{user.id}"

    click_on "Edit Profile"

    expect(current_path).to eq("/profile/#{user.id}/edit")

    name = "New Name"
    city = "New City"
    email = "NewEmail@mail.com"
    fill_in :profile_name, with: name
    fill_in :profile_city, with: city
    fill_in :profile_email, with: email
    fill_in :profile_password, with: user.password
    click_on "Edit User"

    expect(current_path).to eq("/profile/#{user.id}")
    expect(page).to have_content("Your Data Has Been Updated")
    expect(page).to have_content(name)
    expect(page).to have_content(city)
    expect(page).to have_content(email)
    expect(page).to have_content(user.zip)
  end

  it 'user cant make changes to their profile without password' do
    user = create(:user)
    visit "/profile/#{user.id}"

    click_on "Edit Profile"

    expect(current_path).to eq("/profile/#{user.id}/edit")

    name = "New Name"
    city = "New City"
    email = "NewEmail@mail.com"
    fill_in :profile_name, with: name
    fill_in :profile_city, with: city
    fill_in :profile_email, with: email
    click_on "Edit User"

    expect(current_path).to eq("/profile/#{user.id}/edit")
    expect(page).to have_content("Please Enter Password Before Making Changes")
  end

  it 'user cant make changes to their profile without correct password' do
    user = create(:user)
    visit "/profile/#{user.id}"

    click_on "Edit Profile"

    expect(current_path).to eq("/profile/#{user.id}/edit")

    name = "New Name"
    city = "New City"
    email = "NewEmail@mail.com"
    fill_in :profile_name, with: name
    fill_in :profile_city, with: city
    fill_in :profile_email, with: email
    fill_in :profile_password, with: "Wrong password"
    click_on "Edit User"

    expect(current_path).to eq("/profile/#{user.id}/edit")
    expect(page).to have_content("Please Enter CORRECT Password Before Making Changes")
  end

end
