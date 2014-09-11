module ElasticStorage
  module TimelineQuery
    extend self

    def call
      query = {
        _source: %w[title published_at],
        sort: { published_at: { order: :desc }},
      }
      LowLevel::SearchQuery.call query, mapping
    end

  private
    def mapping
      {
        post: ->(hit){ Preview.new hit._source.merge(id: hit._id, type: 'post') },
        favorite_page: ->(hit){ Preview.new hit._source.merge(id: hit._id, type: 'favorite_page') },
      }
    end
  end
end
