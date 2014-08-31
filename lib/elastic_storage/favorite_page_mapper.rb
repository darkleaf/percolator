module ElasticStorage
  module FavoritePageMapper
    extend self

    def from_responce(id, source)
      favorite_page = FavoritePage.new source
      favorite_page.send 'id=', id
      favorite_page
    end
  end
end
