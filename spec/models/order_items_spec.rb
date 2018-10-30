require 'rails_helper'

describe OrderItem, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :item_quantity}
    it {should validate_presence_of :item_price}

  end

  describe 'Relationships' do
    it {should belong_to :item}
    it {should belong_to :order}
  end
end
