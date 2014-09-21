json.array!(@orders) do |order|
  json.extract! order, :id, :name, :consult_date, :consult_time, :delivery_date, :delivery_time
  json.url order_url(order, format: :json)
end
