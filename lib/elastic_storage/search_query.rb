module ElasticStorage
  module SearchQuery
    module_function

    def call(q, page: nil, per_page: nil)
      query =
        if q.present?
          {
            query_string: {
              query: q,
              fields: %w[title^3 keywords^2 description^2 content host url],
              lenient: true,
            }
          }
        else
          { match_all: {} }
        end

      body = {
        _source: %w[title published_at url],
        highlight: {
          pre_tags: %w[<strong>],
          post_tags: %w[</strong>],
          fields: {
            title: { number_of_fragments: 0 },
            url: { number_of_fragments: 0 },
            content: { fragment_size: 100, number_of_fragments: 3 }
          },
        },
        sort: ['_score', { published_at: { order: :desc }}],
        query: query
      }

      result = ElasticStorage::LowLevelSearchQuery.call body, page: page, per_page: per_page

      models = result.map do |i|
        attrs = {
          title: i.fetch('highlight', {}).fetch('title', []).join(' ').presence || i['_source']['title'],
          published_at: i['_source']['published_at'],
          url: i['_source']['url'],
          highlighted_content: i.fetch('highlight', {}).fetch('content', []).join(' ')
        }

        model_class = "#{i['_type']}_search_view".camelcase.constantize
        model_class.load i['_id'], attrs
      end

      StorageCollection.new models, result.total_count, result.limit_value, result.offset_value
    end
  end
end
