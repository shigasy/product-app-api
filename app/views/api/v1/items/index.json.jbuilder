if @items.present?
  json.status 'SUCCESS'
  json.message 'loaded the items'
  json.data do
    json.items do
      json.array!(@items) do |item|
        json.extract! item, :id, :title, :description, :price, :created_at, :updated_at, :shop_id
        json.image rails_blob_url(item.item_image) if item.item_image.attached?
        json.shop item.shop
      end
    end
  end
end