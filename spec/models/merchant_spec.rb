require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through :items }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'model methods' do
    it 'returns a merchant by partial name match' do
      @merchant = create(:merchant, name: "Joe & Sons")
      @merchant1 = create(:merchant, name: "Rainy Day Payday Loans")
      @merchant2 = create(:merchant, name: "Sunshine Roofs")
      @merchant3 = create(:merchant, name: "Ring Around the Posey")

      expect(Merchant.merch_name("Rai")).to eq([@merchant1])
      expect(Merchant.merch_name("day")).to eq([@merchant1])
      expect(Merchant.merch_name("zanzi")).to eq([])
    end
  end
end
