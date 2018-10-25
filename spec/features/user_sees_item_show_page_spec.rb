require 'rails_helper'

describe 'User can navigate to item show page' do
  user = create(:user)
  item_1, item_2 = create_list(:item, 2, user: user)
  visit items_path

  click_link item_1.name
  expect(current_path).to eq(item_path(item_1))
  expect(page).to have_content(item_1.name)
  expect(page).to have_content(item_1.description)
  expect(page).to have_content(item_1.image)
  expect(page).to have_content(item_1.user.name)
  expect(page).to have_content(item_1.inventory_count)
  expect(page).to have_content(item_1.price)

  visit items_path

  click_link item_2.name
  expect(page).to have_content(item_path(item_2))
  expect(page).to have_content(item_2.description)
  expect(page).to have_content(item_2.image)
  expect(page).to have_content(item_2.user.name)
  expect(page).to have_content(item_2.inventory_count)
  expect(page).to have_content(item_2.price)
end
