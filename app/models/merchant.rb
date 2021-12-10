class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  validates_presence_of :name

  def self.merch_name(name_str)
    where('name ILIKE ?', "%#{name_str}%")
    .order(name: :asc)
    .first
  end

  def self.all_merch_name(name_str)
    where('name ILIKE ?', "%#{name_str}%")
    .order(name: :asc)
  end
end
