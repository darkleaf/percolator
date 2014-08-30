module ElasticStorage
  module ClearCommand
    extend Client
    extend self

    def call
      client.delete_by_query index: '_all', body: { query: { match_all: {} } }
    end
  end
end
