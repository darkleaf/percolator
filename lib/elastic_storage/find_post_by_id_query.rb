module ElasticStorage
  module FindPostByIdQuery
    extend Client
    extend self

    def call(id, silent: false )
      params = { index: 'documents', type: 'post', id: id }
      params.merge! ignore: [404] if silent
      responce = client.get params
      return unless responce
      PostMapper.from_responce id, responce['_source']
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
      raise NotFound
    end
  end
end
