json.array!(@jobs) do |job|
  json.extract! job, :id, :batch_id, :type, :started_at, :ended_at
  json.url job_url(job, format: :json)
end
