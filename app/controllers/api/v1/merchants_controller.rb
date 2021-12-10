class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if Merchant.exists?(params[:merchant_id])
      render json: MerchantSerializer.new(Merchant.find(params[:merchant_id]))
    else
      render json: { errors: 'Merchant does not exist.' }, status: 404
    end
  end
end
