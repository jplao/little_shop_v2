require 'rails_helper'

describe 'adding items to cart' do
  describe 'as a user' do

    before :each do
      @item_1, @item_2 = create_list(:item, 2)

    end

    it 'adds an item to cart' do
      visit item_path(@item_1)

      click_on('Add to Cart')

      expect(current_path).to eq(item_path(@item_1))
      expect(page).to have_content('Item Added to Cart')
      expect(page).to have_content('Cart (1)')

      visit item_path(@item_2)

      click_on('Add to Cart')

      expect(current_path).to eq(item_path(@item_2))
      expect(page).to have_content('Item Added to Cart')
      expect(page).to have_content('Cart (2)')

    end
  end
end
