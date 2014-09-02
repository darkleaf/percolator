module ElasticStorage
  module FindFavoritePageByIdQuery
    extend self

    def call(id, silent: false )
      responce = FindByIdQuery.call id, :favorite_page, silent: silent
      return unless responce
      FavoritePageMapper.from_responce id, responce['_source']
    end
  end
end
