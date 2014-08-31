module ElasticStorage
  module FavoritePagesByDateQuery
    extend Client
    extend self

    def call
      responce = client.search index: 'documents', type: 'favorite_page', body: { sort: { published_at: { order: :desc }}}
      responce['hits']['hits'].map do |hit|
        FavoritePageMapper.from_responce hit['_id'], hit['_source']
      end
    end
  end
end
