if @shops.present?
  json.status 'SUCCESS'
  json.message 'loaded the shop'
  json.data do
    json.shops do
      json.array!(@shops) do |shop|
        json.extract! shop, :id, :name, :created_at, :updated_at
      end
    end
  end
end