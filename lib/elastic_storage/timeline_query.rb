module ElasticStorage
  module TimelineQuery
    extend self

    def call(page: nil, per_page: nil)
      query = {
        _source: %w[title published_at],
        sort: { published_at: { order: :desc }},
      }
      LowLevel::SearchQuery.call query, mapping, page: page, per_page: per_page
    end

  private
    def mapping
      {
        post:          ->(hit){ Preview.load_from_hash hit._source.merge(id: hit._id, type: 'post') },
        favorite_page: ->(hit){ Preview.load_from_hash hit._source.merge(id: hit._id, type: 'favorite_page') },
      }
    end
  end
end
