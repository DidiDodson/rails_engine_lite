require 'rails_helper'

describe "Search API" do
  describe 'merchant search methods' do
    it "sends finds a merchant with a search phrase" do
      create(:merchant, name: "BoroBoro")

      get '/api/v1/merchants/find?name=bor'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data][:attributes][:name]).to eq("BoroBoro")
    end

    it "sad path - sends finds a merchant with a search phrase" do
      create(:merchant, name: "Brainy Day")

      get '/api/v1/merchants/find?name=bor'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to eq({})
    end
  end

  describe 'item search methods' do
    it 'finds all items by search phrase' do
      item1 = create(:item, name: 'Zamzam')
      item2 = create(:item, name: 'Zamora')
      item3 = create(:item, name: 'Hizama')
      item4 = create(:item, name: 'Dingdong')

      get '/api/v1/items/find_all?name=zAm'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(3)
      expect(items[:data]).to_not include([item4])
    end
  end
end
