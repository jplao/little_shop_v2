require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :street_address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}
  end

  describe 'Relationships' do
    it {should have_many :items}
    it {should have_many :orders}
  end

  describe 'Methods' do
    before(:each) do
      @merch_1, @merch_2, @merch_3, @merch_4, @merch_5, @merch_6 = create_list(:user, 6, role: 1)

      item_1 = create(:item, user: @merch_1)
      item_2 = create(:item, user: @merch_2)
      item_3 = create(:item, user: @merch_3)
      item_4 = create(:item, user: @merch_4)
      item_5 = create(:item, user: @merch_5)
      item_6 = create(:item, user: @merch_6)

      order_1 = create(:order, status: "complete", user: @merch_6)
      order_2 = create(:order, status: "complete", user: @merch_6)

      create(:order_item, order: order_1, item: item_1, item_quantity: 1, item_price: 1)
      create(:order_item, order: order_1, item: item_2, item_quantity: 3, item_price: 2)
      create(:order_item, order: order_1, item: item_3, item_quantity: 4, item_price: 3)
      create(:order_item, order: order_1, item: item_4, item_quantity: 1, item_price: 2)
      create(:order_item, order: order_2, item: item_1, item_quantity: 20, item_price: 1)
      create(:order_item, order: order_2, item: item_5, item_quantity: 6, item_price: 3)
      create(:order_item, order: order_2, item: item_6, item_quantity: 100, item_price: 1)
    end

    it '.top_merchants' do
      expect(User.top_merchants).to_not include(@merch_4)
      expect(User.top_merchants).to include(@merch_1)
      expect(User.top_merchants).to include(@merch_2)
      expect(User.top_merchants).to include(@merch_3)
      expect(User.top_merchants).to include(@merch_5)
      expect(User.top_merchants).to include(@merch_6)
    end

    it '.top_spending_users' do
      user_1, user_2, user_3 = create_list(:user, 3)

      expect(User.top_spending_users([user_1.id, user_2.id, user_3.id])).to include(user_1, user_2, user_3)
    end
  end
end
