if @items.present?
  json.items do
    json.array!(@items) do |item|
      json.extract! item, :id, :title, :description, :price
      json.image rails_blob_url(item.item_image) if item.item_image.attached?
    end
  end
end