module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :random_widget, WidgetType, null: false
    def random_widget
      Widget.create(name: SecureRandom.uuid)
    end

    field :widgets, WidgetType.connection_type, null: false
    def widgets
      Widget.all
    end
  end
end
