if @shop.present?
  json.status 'SUCCESS'
  json.message 'loaded the shop'
  json.data do
    json.shop do
      json.extract! @shop, :id, :name, :created_at, :updated_at
      json.items @shop.items
    end
  end
end