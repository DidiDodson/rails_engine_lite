class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  def self.item_all_name(name_str)
    where('name ILIKE ?', "%#{name_str}%")
  end

  def merchant?
    merchant.exists?(merchant_id)
  end
end
