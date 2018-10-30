require "rails_helper"

describe 'when any user visits the items index page' do
  it 'displays all item information' do
    user = create(:user)
    item_1, item_2 = create_list(:item, 2, user: user)

    visit root_path
    click_on "All Items"

    expect(current_path).to eq(items_path)
    expect(page).to have_link("#{item_1.name}")
    expect(page).to have_content(item_1.user.name)
    expect(page).to have_css("img[src='#{item_1.image}']")
    expect(page).to have_content(item_1.inventory_count)
    expect(page).to have_content(item_1.price)
    expect(page).to have_link("#{item_2.name}")
    expect(page).to have_content(item_2.user.name)
    expect(page).to have_css("img[src='#{item_2.image}']")
    expect(page).to have_content(item_2.inventory_count)
    expect(page).to have_content(item_2.price)
  end

  it 'shows statistics' do
    merch_1, merch_2, merch_3, merch_4, merch_5, merch_6 = create_list(:user, 6, role: 1)

    item_1 = create(:item, user: merch_1)
    item_2 = create(:item, user: merch_2)
    item_3 = create(:item, user: merch_3)
    item_4 = create(:item, user: merch_4)
    item_5 = create(:item, user: merch_5)
    item_6 = create(:item, user: merch_6)

    order = create(:order, status: "complete", user: merch_6)

    create(:order_item, order: order, item: item_1, item_quantity: 3)
    create(:order_item, order: order, item: item_2, item_quantity: 3)
    create(:order_item, order: order, item: item_3, item_quantity: 4)
    create(:order_item, order: order, item: item_4, item_quantity: 5)
    create(:order_item, order: order, item: item_5, item_quantity: 6)
    create(:order_item, order: order, item: item_6, item_quantity: 1)

    visit items_path
    within(".top_item")do
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_4.name)
      expect(page).to have_content(item_5.name)
    end
  end
end
