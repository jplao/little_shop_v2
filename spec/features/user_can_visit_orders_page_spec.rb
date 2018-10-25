require "rails_helper"

describe "when user visits an order index page" do
  it "displays every order ever made" do
    order = create(:order)
    visit orders_path

    expect(page).to have_content(order.id)
    expect(page).to have_content(order.created_at)
    expect(page).to have_content(order.updated_at)
    expect(page).to have_content(order.status)
    #need to add additional tests here 

  end
end
