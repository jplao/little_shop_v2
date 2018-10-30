RSepc.describe 'checkout process' do
  before(:each) do
    @user = user.create(:user)
    @item = item.create(:item)
    visit login_path
    fill_in :email, with: @user.email
    fill_in :password, with: @user..password
    click_on 'Log In'
  end

  it 'lets user add items and checkout' do
    visit item_path(@item)
    click_on 'Add to Cart'

    click_on 'Cart('
    click_on 'Checkout'

    expect(current_path).to eq(profile_orders_path)
    expect(page).to have_content(@item.name)
    expect(page).to have_content('Pending')
  end
end
