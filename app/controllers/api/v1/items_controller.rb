module Api
  module V1
    # 商品データの登録・検索・変更・削除機能
    class ItemsController < ApplicationController
      def index
        items = Item.all
        render json: { status: 'SUCCESS', message: 'loaded items', data: items }
      end

      def show
        item = Item.find(params[:id])
        render json: { status: 'SUCCESS', message: 'loaded the item', data: item }
      end

      def create
        item = Item.new(item_params)
        if item.save
          render json: { status: 'SUCCESS', message: 'loaded the item', data: item }
        else
          render json: { status: 'ERROR', message: 'loaded the item', data: item.errors }
        end
      end

      def destroy
        item = Item.find(params[:id])
        item.destroy
        render json: { status: 'SUCCESS', message: 'deleted the item', data: item }
      end

      def update
        item = Item.find(params[:id])
        if item.update(item_params)
          render json: { status: 'SUCCESS', message: 'updated the item', data: item }
        else
          render json: { status: 'ERROR', message: 'loaded the item', data: item.errors }
        end
      end

      private

      def item_params
        params.require(:item).permit(:title, :description, :price)
      end
    end
  end
end
