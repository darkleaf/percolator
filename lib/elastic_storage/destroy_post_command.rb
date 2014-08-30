module ElasticStorage
  module DestroyPostCommand
    extend Client
    extend self

    def call(post)
      client.delete index: 'documents', type: 'post', id: post.id, refresh: true
    end
  end
end
