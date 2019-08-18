class Api::V1::ShopsController < ApplicationController
  def index
    @shops = Shop.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end


  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      render 'show', formats: 'json', handlers: 'jbuilder'
    else
      render json: { status: 'ERROR', message: 'loaded the shop', data: @shop.errors }
    end
  end

  def names
    @shop_names = Shop.pluck(:name)
    p @shop_names
    render 'names', formats: 'json', handlers: 'jbuilder'
  end

  def shop_params
    params.require(:shop).permit(:name)
  end
end

# 店舗名はかならずある、店舗に所属しないモノはない