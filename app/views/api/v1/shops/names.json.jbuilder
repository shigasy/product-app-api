if @shop_names.present?
  json.status 'SUCCESS'
  json.message 'loaded the shops'
  json.data do
    json.shop_names @shop_names
  end
end