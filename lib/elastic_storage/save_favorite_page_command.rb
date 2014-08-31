module ElasticStorage
  module SaveFavoritePageCommand
    extend Client
    extend self

    def call(favorite_page)
      client.index index: 'documents', type: 'favorite_page', id: favorite_page.id, body: favorite_page.attributes.except(:id), refresh: true
    end
  end
end
