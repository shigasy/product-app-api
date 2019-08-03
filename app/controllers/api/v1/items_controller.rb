module Api
  module V1
    # 商品データの登録・検索・変更・削除機能
    class ItemsController < ApplicationController
      def index
        items = Item.all
        render json: { status: 'SUCCESS', message: 'loaded items', data: items }
      end

      def create
        item = Item.new(item_params)
        if item.save
          render json: { status: 'SUCCESS', message: 'loaded the post', data: item }
        else
          render json: { status: 'SUCCESS', message: 'loaded the post', data: item.errors }
        end
      end

      private

      def item_params
        params.require(:item).permit(:title, :description, :price)
      end
    end
  end
end
