require 'rails_helper'

describe Order, type: :model do

  describe 'Relationships' do
    it {should belong_to :user}
    it {should have_many :order_items}
    it {should have_many(:items).through(:order_items)}
  end
end
