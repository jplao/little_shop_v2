require "rails_helper"

describe 'when an admin user visits the user index page' do
  it 'they can disable the user and they can no longer sign in' do
    admin = create(:user, role: 2, password: "admin", email: "admin")
    user = create(:user, email: "name", password: "name")
    visit root_path
    click_link "Log In"
    fill_in :email, with: "admin"
    fill_in :password, with: "admin"
    click_button "Log In"

    click_link "All Users"
  
    within("#user#{user.id}") do
      click_button "Disable"
    end

    expect(page).to have_content("User account has been disabled")
    within("#user#{user.id}") do
      expect(page).to have_button("Enable")
    end

    click_link "Log Out"
    click_link "Log In"

    fill_in :email, with: "name"
    fill_in :password, with: "name"
    click_button "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Your account has been compromised, please contact Admin")
  end

  it 'they can enable the user and can now sign in' do
    admin = create(:user, role: 2, password: "admin", email: "admin")
    user = create(:user, email: "name", password: "name")
    visit root_path
    click_link "Log In"
    fill_in :email, with: admin.email
    fill_in :password, with: admin.password
    click_button "Log In"

    click_link "All Users"

    within("#user#{user.id}") do
      click_button "Disable"
    end

    within("#user#{user.id}") do
      click_button "Enable"
    end

    click_link "Log Out"
    click_link "Log In"

    fill_in :email, with: "name"
    fill_in :password, with: "name"
    click_button "Log In"

    expect(current_path).to eq(profile_path)
  end
end
