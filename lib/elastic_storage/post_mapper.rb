module ElasticStorage
  module PostMapper
    extend self

    def from_responce(id, source)
      post = Post.new source
      post.send 'id=', id
      post
    end
  end
end
