class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  def self.item_all_name(name_str)
    where('name ILIKE ?', "%#{name_str}%")
  end

  def self.min_price(price)
    where("unit_price >= #{price}")
  end

  def self.max_price(price)
    where("unit_price <= #{price}")
  end

  def self.all_item_price(price1, price2)
    where("unit_price >= #{price1} AND unit_price <= #{price2}")
  end
end
