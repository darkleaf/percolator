module ElasticStorage
  module LowLevel

    mattr_reader(:index_name){ [:documents, Rails.env].join('_') }
    module_function

    def put(batch, refresh: false)
      bulk batch.map{ |b| { index: b } }, refresh: refresh
    end

    def delete(batch, refresh: false)
      bulk batch.map{ |b| { delete: b } }, refresh: refresh
    end

    def bulk(body, refresh: false)
      client.bulk index: index_name, body: body, refresh: refresh
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

    def refresh_index
      client.indices.refresh index: index_name
    end

    def create_index
      client.indices.create index: index_name, body: index_config
    end

    def remove_index
      client.indices.delete index: index_name, ignore: [404]
    end

    def clear
      client.delete_by_query index: index_name, body: { query: { match_all: {} } }
    end

    def index_config
      YAML.load_file Rails.root.join 'config', 'elastic_index.yml'
    end

    def client
      Thread.current[:elastic_client] ||= Elasticsearch::Client.new url: Figaro.env.elasticsearch_url
    end
  end
end
