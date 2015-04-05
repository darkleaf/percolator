module ElasticStorage
  module LowLevel

    mattr_reader(:index_name){ [:documents, Rails.env].join('_') }
    mattr_accessor(:need_index_refresh){ false }
    module_function

    def put(type, id, document)
      client.index index: index_name, type: type, id: id, body: document, refresh: need_index_refresh
    end

    def delete(type, id)
      client.delete index: index_name, type: type, id: id, refresh: need_index_refresh
    end

    def get(type, id)
      responce = client.get index: index_name, type: type, id: id
      responce['_source']
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
      raise NotFound
    end

    def search(query)
      responce = client.search index: index_name, body: query
      responce['hits']
    end

    def create_index
      client.indices.create index: index_name, body: { settings: Settings.settings }
    end

    def put_mappings
      Settings.mappings.each do |type, mapping|
        client.indices.put_mapping index: index_name, type: type, body: { type => mapping }, ignore_conflicts: true
      end
    end

    def remove_index
      client.indices.delete index: index_name, ignore: [404]
    end

    def clear
      client.delete_by_query index: index_name, body: { query: { match_all: {} } }
    end

    def client
      Thread.current[:elastic_client] ||= Elasticsearch::Client.new url: Figaro.env.elasticsearch_url
    end
  end
end
