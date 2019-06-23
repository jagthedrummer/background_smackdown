json.array!(@batches) do |batch|
  json.extract! batch, :id, :name, :background_type, :job_type, :job_count, :worker_count, :thread_count
  json.extract! batch, :id, :mean, :median, :range, :min, :max, :variance, :standard_deviation
  json.extract! batch, :relative_standard_deviation, :percentile25, :percentile75, :percentile95
  json.extract! batch, :run_time, :wall_time, :modified_run
  json.url batch_url(batch, format: :json)
  json.jobs batch.jobs.order(:started_at) do |job|
    json.extract! job, :type, :started_at, :ended_at, :runtime
  end
  json.system_stats batch.system_stats.order(:created_at) do |ss|
    json.extract! ss, :user_cpu, :sys_cpu, :load_1, :created_at
  end
end
