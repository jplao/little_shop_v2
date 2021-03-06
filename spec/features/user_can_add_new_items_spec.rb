require 'rails_helper'

describe 'as a merchant' do
  before(:each) do
    @merchant = create(:user, role: 1)
    visit root_path
    click_link 'Log In'
    fill_in :email, with: @merchant.email
    fill_in :password, with: @merchant.password
    click_button 'Log In'

    @item = Item.create(name: 'NewItem',
                      description: 'New item description',
                      image: "https://i.etsystatic.com/12134599/r/il/33b06c/1109211976/il_570xN.1109211976_re7r.jpg",
                      price: 999,
                      inventory_count: 888)

  end

  it 'can click link to add new items' do
    visit dashboard_items_path

    click_link 'Add New Item'

    expect(current_path).to eq(new_dashboard_item_path)
    click_link 'Log Out'
  end

  it 'can add a new item' do

    visit new_dashboard_item_path

    fill_in :item_name, with: @item.name
    fill_in :item_description, with: @item.description
    fill_in :item_image, with: @item.image
    fill_in :item_price, with: @item.price
    fill_in :item_inventory_count, with: @item.inventory_count
    click_button 'Create Item'

    expect(current_path).to eq(dashboard_items_path)
    expect(page).to have_content("You have successfully added a new item")

    within("#item#{@merchant.items.last.id}") do
      expect(page).to have_content("Item Id: #{@item.id}")
      expect(page).to have_content("Item Name: #{@item.name}")
      expect(page).to have_content("Price: #{@item.price}")
      expect(page).to have_content("Inventory Count: #{@item.inventory_count}")
      expect(page).to have_css("img[src='#{@item.image}']")
      expect(page).to have_button('Disable')
    end
  end

  it 'wont add a new item if name is left blank' do
    visit new_dashboard_item_path

    fill_in :item_description, with: @item.description
    fill_in :item_image, with: @item.image
    fill_in :item_price, with: @item.price
    fill_in :item_inventory_count, with: @item.inventory_count

    click_button 'Create Item'
    expect(page).to have_content("Name can't be blank")

    visit dashboard_items_path
    expect(page).to_not have_content(@item.name)
  end

  it 'wont add a new item if description is left blank' do
    visit new_dashboard_item_path

    fill_in :item_name, with: @item.name
    fill_in :item_image, with: @item.image
    fill_in :item_price, with: @item.price
    fill_in :item_inventory_count, with: @item.inventory_count

    click_button 'Create Item'
    expect(page).to have_content("Description can't be blank")

    visit dashboard_items_path
    expect(page).to_not have_content(@item.name)
  end

  it 'wont add a new item if price is 0' do
    visit new_dashboard_item_path

    fill_in :item_name, with: @item.name
    fill_in :item_description, with: @item.description
    fill_in :item_image, with: @item.image
    fill_in :item_price, with: 0
    fill_in :item_inventory_count, with: @item.inventory_count

    click_button 'Create Item'
    expect(page).to have_content("Price must be greater than 0")

    visit dashboard_items_path
    expect(page).to_not have_content(@item.name)
  end

  it 'wont add a new item if inventory is 0' do
    visit new_dashboard_item_path

    fill_in :item_name, with: @item.name
    fill_in :item_description, with: @item.description
    fill_in :item_image, with: @item.image
    fill_in :item_price, with: @item.price
    fill_in :item_inventory_count, with: 0

    click_button 'Create Item'
    expect(page).to have_content("Inventory count must be greater than 0")

    visit dashboard_items_path
    expect(page).to_not have_content(@item.name)
  end

  it 'wont add a new item if everything is blank' do
    visit new_dashboard_item_path

    click_button 'Create Item'
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Price can't be blank")
    expect(page).to have_content("Inventory count can't be blank")

    visit dashboard_items_path
    expect(page).to_not have_content(@item.name)
  end

end
