module ElasticStorage
  module SearchQuery
    extend self

    def call(q)
      return [] if q.blank?
      query = {
        sort: ['_score', { published_at: { order: :desc }}],
        query: {
          query_string: {
            query: q,
            fields: %w[title^3 keywords^2 description^2 content host url],
            lenient: true,
          }
        }
      }
      LowLevel::SearchQuery.call query, mapping
    end

  private
    def mapping
      {
        post: ->(id, attrs){ SearchResult.new attrs.merge(id: id, type: 'post') },
        favorite_page: ->(id, attrs){ SearchResult.new attrs.merge(id: id, type: 'favorite_page') },
      }
    end
  end
end
