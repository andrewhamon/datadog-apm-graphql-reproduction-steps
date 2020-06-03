class DatadogTestSchema < GraphQL::Schema
  use(
    GraphQL::Tracing::DataDogTracing,
    service: "datadog_test-graphql",
  )

  mutation(Types::MutationType)
  query(Types::QueryType)
end
