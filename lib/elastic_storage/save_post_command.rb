module ElasticStorage
  module SavePostCommand
    extend Client
    extend self

    def call(post)
      client.index index: 'documents', type: 'post', id: post.id, body: post.attributes.except(:id), refresh: true
    end
  end
end
