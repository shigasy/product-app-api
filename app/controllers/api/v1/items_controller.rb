module Api
  module V1
    # 商品データの登録・検索・変更・削除機能
    class ItemsController < ApplicationController
      def index
        @items = Item.with_attached_item_image.includes(:shop)
        render 'index', formats: 'json', handlers: 'jbuilder'
      end

      def show
        @item = Item.find(params[:id])
        render 'show', formats: 'json', handlers: 'jbuilder'
      end

      def create
        @item = Item.new(item_params)
        @item[:shop_id] = Shop.find_by_name(item_params[:shop_id])&.id
        if @item.save
          @item.parse_base64(item_params[:image])
          render 'show', formats: 'json', handlers: 'jbuilder'
        else
          render json: { status: 'ERROR', message: 'loaded the item', data: @item.errors }
        end
      end

      def destroy
        item = Item.find(params[:id])
        item.destroy
        render json: { status: 'SUCCESS', message: 'deleted the item', data: item }
      end

      def update
        @item = Item.find(params[:id])
        if @item.update(item_params)
          render 'show', formats: 'json', handlers: 'jbuilder'
        else
          render json: { status: 'ERROR', message: 'loaded the item', data: @item.errors }
        end
      end

      def search
        @items = Item.search_title_description(params[:word])
        render 'index', formats: 'json', handlers: 'jbuilder'
      end

      private

      def item_params
        params.require(:item).permit(:title, :description, :price, :image, :shop_id)
      end

    end
  end
end
