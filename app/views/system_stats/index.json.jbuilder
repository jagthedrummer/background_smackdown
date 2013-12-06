json.array!(@system_stats) do |system_stat|
  json.extract! system_stat, :id, :user_cpu, :sys_cpu, :load_1, :load_5, :load_15
  json.url system_stat_url(system_stat, format: :json)
end
