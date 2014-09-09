module ElasticStorage
  module TimelineQuery
    extend self

    def call
      query = {
        sort: { published_at: { order: :desc }},
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
