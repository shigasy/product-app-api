if @item.present?
  json.status 'SUCCESS'
  json.message 'loaded the item'
  json.data do
    json.item do
      json.extract! @item, :id, :title, :description, :price, :created_at, :updated_at
      json.image rails_blob_url(@item.item_image) if @item.item_image.attached?
      json.shop @item.shop
    end
  end
end