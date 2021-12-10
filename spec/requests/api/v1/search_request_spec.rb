require 'rails_helper'

describe "Search API" do
  describe 'merchant search methods' do
    it "finds a merchant with a search phrase" do
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
      expect(merchant).to have_key(:errors)
      expect(merchant[:errors]).to eq('No name given.')
    end

    it "finds all merchants with a search phrase" do
      merchant1 = create(:merchant, name: "BoroBoro")
      merchant2 = create(:merchant, name: "Bonborb")
      merchant3 = create(:merchant, name: "Bonbor")
      merchant4 = create(:merchant, name: "Bonjour")

      get '/api/v1/merchants/find_all?name=bor'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(3)
      expect(merchants[:data]).to_not include(merchant4)
    end

    it "edge case nil name - finds all merchants with a search phrase" do
      create(:merchant, name: 'Blingaling')

      get '/api/v1/merchants/find?name=nil'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to eq({})
    end

    it "edge case no name - finds all merchant with a search phrase" do
      create(:merchant, name: 'BoroBoro')

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

    it "finds an item with a search phrase" do
      create(:item, name: "BoroBoro")

      get '/api/v1/items/find?name=bor'

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data][:attributes][:name]).to eq("BoroBoro")
    end

    it "edge case nil name - finds an item with a search phrase" do
      create(:item, name: 'BoroBoro')

      get '/api/v1/items/find?name=nil'

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to eq({})
    end

    it "edge case no name - finds an item with a search phrase" do
      create(:item, name: 'BoroBoro')

      get '/api/v1/items/find'

      expect(response).to_not be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to eq(nil)
      expect(item).to eq({ errors: 'No name given.' })
    end
  end
end
