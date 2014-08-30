module ElasticStorage
  module PostsByDateQuery
    extend Client
    extend self

    def call
      responce = client.search index: 'documents', type: 'post', body: { sort: { published_at: { order: :desc }}}
      responce['hits']['hits'].map do |hit|
        PostMapper.from_responce hit['_id'], hit['_source']
      end
    end
  end
end
