require 'rails_helper'

describe "MerchantItems API" do
  it 'can get one merchant by its id' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    id = merchant.id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(id.to_s)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end
