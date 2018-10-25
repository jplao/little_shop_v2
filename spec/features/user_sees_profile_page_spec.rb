require 'rails_helper'

describe 'user sees profile page' do
  context 'logged in as any type of user' do
    it 'displays all profile data' do
      user = create(:user)

      visit user_path(user)

      expect(page).to have_content(user.name)
      expect(page).to have_content(user.street_address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
      expect(page).to have_content(user.email)
      expect(page).to have_link("Edit Profile")
    end

    it "displays profile stats" do
      # TODO Flesh this out
      user = create(:user)
      visit user_path(user)
      expect(page).to have_content("Statistics")
    end

    it "shows no orders link if user has no orders" do
      user = create(:user)
      visit user_path(user)
      expect(page).not_to have_link("My Orders")
    end

    it "shows orders link if user has orders" do
      user = create(:user)
      order = create(:order, user: user)
      visit user_path(user)
      expect(page).to have_link("My Orders")
    end
  end

  context 'as a visitor' do

  end

end
