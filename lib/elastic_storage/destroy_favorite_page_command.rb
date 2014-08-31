module ElasticStorage
  module DestroyFavoritePageCommand
    extend Client
    extend self

    def call(post)
      client.delete index: 'documents', type: 'favorite_page', id: post.id, refresh: true
    end
  end
end
