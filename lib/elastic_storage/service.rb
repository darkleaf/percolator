module ElasticStorage
  module Service
    module CreateIndicesCommand
      extend Client
      extend self

      def call
        client.indices.create index: :documents, body: { settings: Settings.settings }
      end
    end

    module PutMappingsCommand
      extend Client
      extend self

      def call
        Settings.mappings.each do |type, mapping|
          client.indices.put_mapping index: :documents, type: type, body: { type => mapping }, ignore_conflicts: true
        end
      end
    end

    module RemoveIndicesCommand
      extend Client
      extend self

      def call
        client.indices.delete index: '_all'
      end
    end

    module ClearCommand
      extend Client
      extend self

      def call
        client.delete_by_query index: '_all', body: { query: { match_all: {} } }
      end
    end
  end
end
