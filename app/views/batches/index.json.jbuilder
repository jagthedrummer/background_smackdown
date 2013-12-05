json.array!(@batches) do |batch|
  json.extract! batch, :id, :name
  json.url batch_url(batch, format: :json)
end
