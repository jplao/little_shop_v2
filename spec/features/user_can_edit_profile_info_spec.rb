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
    click_on "Edit User"

    expect(current_path).to eq("/profile/#{user.id}")
    expect(page).to have_content("Your Data Has Been Updated")
  end

end
