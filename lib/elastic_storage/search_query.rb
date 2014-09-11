module ElasticStorage
  module SearchQuery
    extend self

    def call(q)
      return [] if q.blank?
      query = {
        _source: %w[title published_at],
        highlight: {
          pre_tags: %w[<strong>],
          post_tags: %w[</strong>],
          fields: {
            title: { number_of_fragments: 0 },
            content: { fragment_size: 100, number_of_fragments: 3 }
          },
        },
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
        post:          ->(hit){ SearchResult.new attrs_from_hit(hit).merge(type: 'post') },
        favorite_page: ->(hit){ SearchResult.new attrs_from_hit(hit).merge(type: 'favorite_page') },
      }
    end

    def attrs_from_hit(hit)
      {
        id: hit._id,
        title: hit.highlight.try(:title).try(:join, ' ') || hit._source.title,
        published_at: hit._source.published_at,
        highlighted_content: hit.highlight.try(:content).try(:join, ' ')
      }
    end
  end
end
