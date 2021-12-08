require 'rails_helper'

describe "MerchantItems API" do
  it "sends a list of merchant items" do
    merch_id = create(:merchant).id
    create_list(:item, 3, merchant_id: merch_id)

    get "/api/v1/merchants/#{merch_id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
      expect(item[:attributes][:merchant_id]).to eq(merch_id)
    end
  end

  it 'can get one merchant by its id' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    id = merchant.id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id.to_s)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end


    it 'can get an items merchant' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchant"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item[:merchant_id].to_s).to eq(merchant[:data][:id])
    end

    it 'sad path - can get an items merchant' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchant"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item[:merchant_id].to_s).to eq(merchant[:data][:id])
    end
end
