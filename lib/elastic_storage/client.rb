module ElasticStorage
  module Client
    def client
      Thread.current[:elastic_client] ||= Elasticsearch::Client.new url: Figaro.env.elasticsearch_url
    end
  end
end
