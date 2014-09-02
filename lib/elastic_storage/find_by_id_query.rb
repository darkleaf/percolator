module ElasticStorage
  module FindByIdQuery
    extend Client
    extend self

    def call(id, type, silent: false )
      params = { index: 'documents', type: type, id: id }
      params.merge! ignore: [404] if silent
      client.get params
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
      raise NotFound
    end
  end
end
