require 'rails_helper'

describe 'cart functionality' do
  before :each do

    @item_1 = create(:item, inventory_count: 3)
    @item_2 = create(:item, inventory_count: 3)
    @merchant_1, @merchant_2 = create_list(:user, 2)

    @merchant_1.items = [@item_1]
    @merchant_2.items = [@item_2]
  end

  context 'as any type of user' do

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
      visit cart_path
      expect(page).to_not have_content(@item_1.name)
      expect(page).to_not have_content(@item_1.user.name)
      expect(page).to_not have_content("$#{@item_1.price.round(2)}")
      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@item_2.user.name)
      expect(page).to_not have_content("$#{@item_2.price.round(2)}")

      visit item_path(@item_1)
      click_on('Add to Cart')

      visit item_path(@item_2)
      click_on('Add to Cart')
      click_on('Add to Cart')

      click_on('Cart (')

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

    it 'shows a the subtotal' do

      visit item_path(@item_1)
      click_on('Add to Cart')
      visit item_path(@item_2)
      click_on('Add to Cart')
      click_on('Add to Cart')

      click_on('Cart (')

      expect(page).to have_content("Subtotal: $#{@item_1.price}")
      expect(page).to have_content("Subtotal: $#{@item_2.price * 2}")
      expect(page).to have_content("Total: $#{(@item_1.price) + (@item_2.price * 2)}")
    end

    it 'cart can be emptied' do

      visit item_path(@item_1)
      click_on('Add to Cart')
      visit item_path(@item_2)
      click_on('Add to Cart')
      click_on('Add to Cart')


      click_on('Cart (')

      click_on('Empty Cart')

      expect(current_path).to eq(cart_path)

      expect(page).to_not have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)

    end

    it 'individual item can be deleted from cart' do

      visit item_path(@item_1)
      click_on('Add to Cart')
      visit item_path(@item_2)
      click_on('Add to Cart')
      click_on('Add to Cart')

      click_on('Cart (')

      within "#item-#{@item_1.id}" do
        click_button('🗑')
      end

      expect(page).to_not have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)

    end

    it 'individual items can be incremented and decremented' do


      visit item_path(@item_1)
      click_on('Add to Cart')


      click_on('Cart (')

      click_on('➕')
      expect(page).to have_content("Quantity: 2")

      click_on('➕')
      expect(page).to have_content("Quantity: 3")

      click_on('➕')
      expect(page).to have_content("Quantity: 3")

      click_button('➖')
      expect(page).to have_content("Quantity: 2")

      click_button('➖')
      expect(page).to have_content("Quantity: 1")

      click_button('➖')
      expect(page).to_not have_content(@item_1.name)

    end

  end

  context 'as a visitor' do

    it "asks me to log in or register to finish order" do
      visit cart_path
      expect(page).to have_content('Please Log In or Register to Finish Checkout')
    end

    it "goes to registration when you click register" do
      visit cart_path
      within ('#checkout-notice') do
        click_link 'Register'
        expect(current_path).to eq(register_path)
      end
    end

    it "goes to log in when you click log in" do
      visit cart_path
      within ('#checkout-notice') do
        click_link 'Log In'
        expect(current_path).to eq(login_path)
      end

    end
  end

  context 'as a registered user' do

    before :each do
      @user = create(:user)
      visit root_path
      click_link "Log In"
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log In"
    end

    it "shows me a link to checkout" do
      visit cart_path
      expect(page).to have_button('Checkout')
    end

  end
end
