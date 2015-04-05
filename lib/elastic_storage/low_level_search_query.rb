module ElasticStorage
  module LowLevelSearchQuery
    extend self

    def call(query, page: nil, per_page: nil)
      i_size = size(per_page)
      i_from = from(page, i_size)

      query_with_pagination = query.merge from: i_from, size: i_size

      response = ElasticStorage.low_level.search query_with_pagination
      wrap_response response, i_size, i_from
    end

    private
    def from(page, size)
      i_page = page.to_i > 1 ? page.to_i : 1
      (i_page - 1) * size
    end

    def size(per_page)
      default = 10
      i_per_page = per_page.to_i
      return default if i_per_page <= 0
      i_per_page
    end

    def wrap_response(response, size, from)
      StorageCollection.new response['hits'], response['total'], size, from
    end
  end
end
