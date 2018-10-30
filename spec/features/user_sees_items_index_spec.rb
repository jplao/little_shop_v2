require "rails_helper"

describe 'when any user visits the items index page' do
  it 'displays all item information for enabled items' do
    user = create(:user)
    item_1 = create(:item, user: user, active: true)
    item_2 = create(:item, user: user, active: false)

    visit root_path
    click_on "All Items"

    expect(current_path).to eq(items_path)
    expect(page).to have_link("#{item_1.name}")
    expect(page).to have_content(item_1.user.name)
    expect(page).to have_css("img[src='#{item_1.image}']")
    expect(page).to have_content(item_1.inventory_count)
    expect(page).to have_content(item_1.price)
    expect(page).not_to have_link("#{item_2.name}")
    expect(page).not_to have_content(item_2.inventory_count)
    expect(page).not_to have_content(item_2.price)
  end
end
