require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  describe 'GET #index /api/v1/items' do
    before do
      @item = FactoryBot.create(:item)
      get :index
      @json = JSON.parse(response.body)
    end

    it '200が返ってくる' do
      expect(response.status).to eq 200
    end

    it '取得したデータのtitleがitem_title' do
      expect(@json['data'][0]['title']).to eq @item.title
    end
  end

  describe 'GET #show /api/v1/items/:id' do
  end

  describe 'POST #create /api/v1/items' do
    before do
      @params = FactoryBot.attributes_for(:item)
    end

    it '200が返ってくる' do
      post :create, params: { item: @params }
      expect(response.status).to eq 200
    end

    it 'Itemレコードが1増える' do
      expect { post :create, params: { item: @params } }.to change(Item, :count).by(1)
    end
  end

  describe 'DELETE #destroy /api/v1/items/:id' do
    before do
      @item = FactoryBot.create(:item)
    end

    it '200が返ってくる' do
      delete :destroy, params: { id: @item.id }
      expect(response.status).to eq 200
    end

    it 'Itemレコードが1減る' do
      expect { delete :destroy, params: { id: @item.id } }.to change(Item, :count).by(-1)
    end
  end

  describe 'PATCH #update /api/v1/items/:id' do
    before do
      @item = FactoryBot.create(:item)
    end

    it '200が返ってくる' do
      item = FactoryBot.attributes_for(:item, title: 'title_update')
      patch :update, params: { id: @item.id, item: item }
      expect(response.status).to eq 200
    end

    it 'Itemレコードが更新される' do
      item = FactoryBot.attributes_for(:item, title: 'title_update')
      patch :update, params: { id: @item.id, item: item }
      get :index
      @json = JSON.parse(response.body)
      response_title = @json['data'][0]['title']
      expect(response_title).to eq item[:title]
    end
  end
end
