class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    if Item.exists?(params[:item_id])
      render json: ItemSerializer.new(Item.find(params[:item_id]))
    else
      render json: { errors: 'Item does not exist.' }, status: 404
    end
  end

  def create
    new_item = Item.new(item_params)

    if new_item.valid? == true

      render json: ItemSerializer.new(Item.create(item_params)), status: 201
    else
      render json: { errors: 'Missing required field.' }, status: 404
    end
  end

  def update
    item = Item.find(params[:item_id])

    if item_params.include?('merchant_id')
      if Merchant.exists?(item_params['merchant_id']) == true
        item.update(item_params)

        render json: ItemSerializer.new(item)
      elsif Merchant.exists?(item_params['merchant_id']) == false
        render json: { errors: 'No such merchant.' }, status: 400
      end
    else
      item.update(item_params)
      render json: ItemSerializer.new(item)
    end
  end

  def destroy
    render json: Item.delete(params[:item_id]), status: 204
  end

  def find
    all_item_name = Item.item_all_name(params[:name])

    render json: ItemSerializer.new(all_item_name)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
