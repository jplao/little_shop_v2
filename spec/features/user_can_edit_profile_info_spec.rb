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
    fill_in :name, with: name
    fill_in :city, with: city
    fill_in :email, with: email
    click_on "Edit User"

    expect(current_path).to eq("profile/#{user.id}")
    expect(flash[:message]).to_not be_nil
  end

end
