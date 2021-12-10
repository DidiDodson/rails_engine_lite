require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through :invoice_items }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
  end

  describe 'model methods' do
    it 'returns a list of items by partial name match' do
      @item = create(:item, name: "FlimFlam")
      @item1 = create(:item, name: "Flimsy Ducks")
      @item2 = create(:item, name: "Snazzleflim")
      @item3 = create(:item, name: "Ding-flim-Ding")

      expect(Item.item_all_name("flim")).to eq([@item, @item1, @item2, @item3])
    end

    it 'returns a list of items by min price' do
      @item = create(:item, unit_price: 5.2)
      @item1 = create(:item, unit_price: 10.7)
      @item2 = create(:item, unit_price: 30.6)
      @item3 = create(:item, unit_price: 3.4)

      expect(Item.min_price(5.1)).to eq([@item, @item1, @item2])
    end

    it 'returns a list of items by max price' do
      @item = create(:item, unit_price: 5.2)
      @item1 = create(:item, unit_price: 10.7)
      @item2 = create(:item, unit_price: 30.6)
      @item3 = create(:item, unit_price: 3.4)

      expect(Item.max_price(20.0)).to eq([@item, @item1, @item3])
    end

    it 'returns an item by partial name match' do
      @item = create(:item, name: "FlimFlam")
      @item1 = create(:item, name: "Flimsy Ducks")
      @item2 = create(:item, name: "Snazzleflim")
      @item3 = create(:item, name: "Ding-flim-Ding")

      expect(Item.item_by_name("flim")).to eq(@item3)
    end
  end
end
