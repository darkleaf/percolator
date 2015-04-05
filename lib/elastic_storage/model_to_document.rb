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

    module FavoritePage
      module_function

      def call(page)
        {
          url: page.url,
          host: page.host,
          title: page.title,
          description: page.description,
          keywords: page.keywords,
          content: page.content,
          published_at: page.created_at,
        }
      end
    end
  end
end
