class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    merchant_name = Merchant.merch_name(params[:name]).first

    if merchant_name == nil
      render json: { data: nil }
    else
      render json: MerchantSerializer.new(merchant_name)
    end
  end
end
