module Api
  module V1
    # 商品データの登録・検索・変更・削除機能
    class ItemsController < ApplicationController
      def index
        items = Item.all
        render json: { status: 'SUCCESS', message: 'loaded items', data: items }
      end
    end
  end
end
