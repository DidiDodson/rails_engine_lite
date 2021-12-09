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

    it "sad path - finds a merchant with a search phrase" do
      create(:merchant, name: "Brainy Day")

      get '/api/v1/merchants/find?name=bor'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to eq({})
    end

    it "edge case nil name - finds a merchant with a search phrase" do
      create(:merchant, name: 'Bob')

      get '/api/v1/merchants/find?name=nil'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to eq({})
    end

    it "edge case no name - finds a merchant with a search phrase" do
      create(:merchant, name: 'Bob')

      get '/api/v1/merchants/find'

      expect(response).to_not be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to eq(nil)
      expect(merchant).to eq({ errors: 'No name given.' })
    end
  end

  describe 'item search methods' do
    it 'finds all items by name search phrase' do
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

    it 'sad path name & max_price - finds all items by name search phrase' do
      item1 = create(:item, name: 'Zamzam')
      item2 = create(:item, name: 'Zamora')
      item3 = create(:item, name: 'Hizama')
      item4 = create(:item, name: 'Dingdong')

      get '/api/v1/items/find_all?name=zAm&max_price=5.2'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key(:errors)
      expect(items[:errors]).to eq("Incorrect search terms.")
    end

    it 'sad path name & min_price - finds all items by name search phrase' do
      item1 = create(:item, name: 'Zamzam')
      item2 = create(:item, name: 'Zamora')
      item3 = create(:item, name: 'Hizama')
      item4 = create(:item, name: 'Dingdong')

      get '/api/v1/items/find_all?name=zAm&min_price=50.2'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key(:errors)
      expect(items[:errors]).to eq("Incorrect search terms.")
    end

    it 'finds all items by minimum price' do
      item1 = create(:item, unit_price: 35.2)
      item2 = create(:item, unit_price: 17.62)
      item3 = create(:item, unit_price: 95.22)
      item4 = create(:item, unit_price: 12.0)

      get '/api/v1/items/find_all?min_price=15.0'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(3)
      expect(items[:data]).to_not include([item4])
    end

    it 'finds all items by maximum price' do
      item1 = create(:item, unit_price: 35.2)
      item2 = create(:item, unit_price: 17.62)
      item3 = create(:item, unit_price: 95.22)
      item4 = create(:item, unit_price: 12.0)

      get '/api/v1/items/find_all?max_price=36.3'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(3)
      expect(items[:data]).to_not include([item3])
    end

    it 'finds all items by minimum and maximum price' do
      item1 = create(:item, unit_price: 35.2)
      item2 = create(:item, unit_price: 17.62)
      item3 = create(:item, unit_price: 95.22)
      item4 = create(:item, unit_price: 12.0)

      get '/api/v1/items/find_all?min_price=18.0&max_price=36.3'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(1)
      expect(items[:data]).to_not include([item2, item3, item4])
    end

    xit 'edge case no param - finds all items by name search phrase' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)
      item4 = create(:item)

      get '/api/v1/items/find_all'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key(:errors)
      expect(items[:errors]).to eq('No search term given.')
    end
  end
end
