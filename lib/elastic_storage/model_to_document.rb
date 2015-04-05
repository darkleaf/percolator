module ElasticStorage
  module ModelToDocument
    module Post
      module_function

      def call(post)
        content_result = PostHtmlPipeline.call(post.content)
        {
          title: post.title,
          content: content_result[:output].to_s,
          published_at: post.created_at,
          relative_query_without_self: post.relative_query_without_self
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
