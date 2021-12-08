class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:item_id]))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)), status: 201
  end

  def update

    render json: ItemSerializer.new(Item.update(params[:item_id]), item_params)


    # render json: ItemSerializer.new(Item.update(params[:item_id], item_params))

    # if Merchant.exists?(item.merchant_id)
    #
    #   render json: ItemSerializer.new(item.update(params[:item_id], item_params))
    # else
    #   render json: { status: "error", code: 400 }
    # end
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
