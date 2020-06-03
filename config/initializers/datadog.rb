Datadog.configure do |c|
  service_name = "datadog_test"
  c.use(
    :rails,
    service_name: service_name,
    database_service: "#{service_name}-db",
    cache_service: "#{service_name}-cache",
  )
  c.service = service_name
  c.env = Rails.env
end
