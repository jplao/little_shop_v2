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

  it 'shows top items' do
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

    it 'shows top merchants' do
      merch_1, merch_2, merch_3, merch_4, merch_5, merch_6 = create_list(:user, 6, role: 1)

      item_1 = create(:item, user: merch_1)
      item_2 = create(:item, user: merch_2)
      item_3 = create(:item, user: merch_3)
      item_4 = create(:item, user: merch_4)
      item_5 = create(:item, user: merch_5)
      item_6 = create(:item, user: merch_6)

      order_1 = create(:order, status: "complete", user: merch_6)
      order_2 = create(:order, status: "complete", user: merch_6)

      create(:order_item, order: order_1, item: item_1, item_quantity: 1)
      create(:order_item, order: order_1, item: item_2, item_quantity: 3)
      create(:order_item, order: order_1, item: item_3, item_quantity: 4)
      create(:order_item, order: order_1, item: item_4, item_quantity: 1)

      create(:order_item, order: order_2, item: item_1, item_quantity: 20)
      create(:order_item, order: order_2, item: item_5, item_quantity: 6)
      create(:order_item, order: order_2, item: item_6, item_quantity: 100)

      visit items_path
      within(".top_merch")do
        expect(page).to have_content(merch_1.name)
        expect(page).to have_content(merch_2.name)
        expect(page).to have_content(merch_3.name)
        expect(page).to have_content(merch_5.name)
        expect(page).to have_content(merch_6.name)

        expect(page).not_to have_content(merch_4.name)
      end
    end

    it 'shows top 3 merchants by time to fulfill' do
      item_1 = create(:item)
      item_2 = create(:item)

      order_item_1 = create(:order_item,fulfill: true, created_at: 10.days.ago.to_date, item: item_1)
      order_item_2 = create(:order_item,fulfill: true, created_at: 15.days.ago.to_date, item: item_1)

      order_item_3 = create(:order_item,fulfill: true, created_at: 1.days.ago.to_date, item: item_2)
      order_item_4 = create(:order_item,fulfill: true, created_at: 2.days.ago.to_date, item: item_2)

      order_item_5 = create(:order_item, fulfill: true, created_at: 5.days.ago.to_date)
      order_item_6 = create(:order_item, fulfill: true, created_at: 6.days.ago.to_date)
      order_item_7 = create(:order_item, fulfill: true, created_at: 7.days.ago.to_date)
      order_item_8 = create(:order_item, fulfill: true, created_at: 3.days.ago.to_date)


      visit items_path
      expect(page).to have_content("Merchants Who Ship Fastest")
      expect(page).to have_content("Merchants Who Ship Slowest")
      binding.pry
      within(".quick-merchants") do

        expect(page).to have_content(order_item_3.item.user.name)
        expect(page).to have_content(order_item_4.item.user.name)
        expect(page).to have_content(order_item_5.item.user.name)
        expect(page).to have_content(order_item_8.item.user.name)

        expect(page).to_not have_content(order_item_1.item.user.name)
        expect(page).to_not have_content(order_item_2.item.user.name)
        expect(page).to_not have_content(order_item_6.item.user.name)
        expect(page).to_not have_content(order_item_7.item.user.name)
      end
    end
end
