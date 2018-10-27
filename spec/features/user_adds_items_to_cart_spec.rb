require 'rails_helper'

describe 'adding items to cart' do
  describe 'as a user' do

    before :each do

      @item_1, @item_2 = create_list(:item, 2)
      @merchant_1, @merchant_2 = create_list(:user, 2)

      @merchant_1.items = [@item_1]
      @merchant_2.items = [@item_2]
    end

    it 'adds an item to cart' do
      visit item_path(@item_1)

      click_on('Add to Cart')

      expect(current_path).to eq(item_path(@item_1))
      expect(page).to have_content('Item Added to Cart')
      expect(page).to have_content('Cart (1)')

      visit item_path(@item_2)

      click_on('Add to Cart')
      click_on('Add to Cart')

      expect(current_path).to eq(item_path(@item_2))
      expect(page).to have_content('Item Added to Cart')
      expect(page).to have_content('Cart (3)')
    end

    it 'shows items that have been added to cart' do

      visit item_path(@item_1)
      click_on('Add to Cart')

      visit item_path(@item_2)
      click_on('Add to Cart')
      click_on('Add to Cart')

      visit cart_path
      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.user.name)
        expect(page).to have_content("$#{@item_1.price.round(2)}")
        expect(page).to have_content("Quantity: 1")
      end
      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.user.name)
        expect(page).to have_content("$#{@item_2.price.round(2)}")
        expect(page).to have_content("Quantity: 2")
      end
    end

    it 'shows items that have been added to cart' do

      visit item_path(@item_1)
      click_on('Add to Cart')
      visit item_path(@item_2)
      click_on('Add to Cart')

      visit cart_path

      expect(page).to have_button("Empty Cart")
      click_on "Empty Cart"
      visit cart_path
      expect(page).to_not have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
    end
  end
end
