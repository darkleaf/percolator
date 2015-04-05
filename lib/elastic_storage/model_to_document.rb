module ElasticStorage
  module ModelToDocument
    module Post
      module_function

      def call(post)
        {
          title: post.title,
          content: post.content,
          published_at: post.created_at,
        }
      end
    end
  end
end
