module ElasticStorage
  module LowLevel
    module FindByIdQuery
      extend Client
      extend self

      def call(type, id, mapper, silent: false )
        params = { index: 'documents', type: type, id: id }
        params.merge! ignore: [404] if silent
        response = client.get params
        return unless response
        mapper.call id, response['_source']
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        raise NotFound
      end
    end

    module SearchQuery
      extend Client
      extend self

      # map = { type: ->(id, source){ Model.new } }
      def call(query, map)
        mapping = map.with_indifferent_access
        types = mapping.keys.join(',')
        response = client.search index: 'documents', type: types, body: query
        wrap_response response, mapping
      end

      private
      def wrap_response(response, mapping)
        response['hits']['hits'].map do |hit|
          type = hit['_type']
          mapper = mapping[type]
          mapper.call hit['_id'], hit['_source']
        end
      end
    end

    module SaveCommand
      extend Client
      extend self

      def call(type, id, attributes)
        client.index index: 'documents', type: type, id: id, body: attributes, refresh: true
      end
    end

    module DestroyCommand
      extend Client
      extend self

      def call(type, id)
        client.delete index: 'documents', type: type, id: id, refresh: true
      end
    end
  end
end
