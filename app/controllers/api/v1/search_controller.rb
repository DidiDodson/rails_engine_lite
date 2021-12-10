class Api::V1::SearchController < ApplicationController

  def find_merchant
    merchant_name = Merchant.merch_name(params[:name])
    if params[:name] == nil
      render json: { errors: 'No name given.' }, status: 400
    elsif params[:name].empty? == true
      render json: { errors: 'No name given.' }, status: 400
    else
      if merchant_name == nil
        render json: { data: {} }
      else
        render json: MerchantSerializer.new(merchant_name)
      end
    end
  end

  def find_all_merchants
    merchant_names = Merchant.all_merch_name(params[:name])
    if params[:name] == nil
      render json: { errors: 'No name given.' }, status: 400
    elsif params[:name].empty? == true
      render json: { errors: 'No name given.' }, status: 400
    else
      if merchant_names == nil
        render json: { data: {} }
      else
        render json: MerchantSerializer.new(merchant_names)
      end
    end
  end

  def find_item_name
    item_name = Item.item_by_name(params[:name])

    if params[:name] == nil
      render json: { errors: 'No name given.' }, status: 400
    elsif params[:name].empty? == true
      render json: { errors: 'No name given.' }, status: 400
    else
      if ((params[:name].present? && params[:min_price]).present?)
        render json: { errors: 'Incorrect search terms.' }
      elsif params[:name].present?
        if item_name == nil
          render json: { data: {} }
        else
          render json: ItemSerializer.new(item_name)
        end
      end
    end
  end

  def find_all_items
    all_item_name = Item.item_all_name(params[:name])
    all_item_min_price = Item.min_price(params[:min_price])
    all_item_max_price = Item.max_price(params[:max_price])
    all_item_price_search = Item.all_item_price(params[:min_price], params[:max_price])

    if ((params[:name].present? && params[:min_price]).present?)
      render json: { errors: 'Incorrect search terms.' }
    elsif ((params[:name].present? && params[:max_price]).present?)
      render json: { errors: 'Incorrect search terms.' }
    elsif ((params[:min_price].present? && params[:max_price]).present?)
      render json: ItemSerializer.new(all_item_price_search)
    elsif params[:name].present?
      render json: ItemSerializer.new(all_item_name)
    elsif params[:min_price].present?
      render json: ItemSerializer.new(all_item_min_price)
    elsif params[:max_price].present?
      render json: ItemSerializer.new(all_item_max_price)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id, :min_price, :max_price)
  end
end
