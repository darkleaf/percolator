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
        mapper.call Hashie::Mash.new(response)
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        raise NotFound
      end
    end

    module SearchQuery
      extend Client
      extend self

      # map = { type: ->(id, source){ Model.new } }
      def call(query, map, page: nil, per_page: nil)
        i_size = size(per_page)
        i_from = from(page, i_size)

        query_with_pagination = query.merge from: i_from, size: i_size

        mapping = map.with_indifferent_access
        types = mapping.keys.join(',')
        response = client.search index: 'documents', type: types, body: query_with_pagination
        wrap_response response, mapping, i_size, i_from
      end

      private
      def from(page, size)
        i_page = page.to_i > 1 ? page.to_i : 1
        (i_page - 1) * size
      end

      def size(per_page)
        default = 10
        i_per_page = per_page.to_i
        return default if i_per_page <= 0
        i_per_page
      end

      def wrap_response(response, mapping, size, from)
        models = response['hits']['hits'].map do |hit|
          type = hit['_type']
          mapper = mapping[type]
          mapper.call Hashie::Mash.new(hit)
        end

        StorageCollection.new models, response['hits']['total'], size, from
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
