class Api::V1::SearchController < ApplicationController

  def find_merchant
    merchant_name = Merchant.merch_name(params[:name])

    if merchant_name == nil
      render json: { data: {} }
    else
      render json: MerchantSerializer.new(merchant_name)
    end
  end

  def find_items
    all_item_name = Item.item_all_name(params[:name])

    render json: ItemSerializer.new(all_item_name)
  end
end
