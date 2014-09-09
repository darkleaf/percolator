module ElasticStorage
  module FavoritePageType
    module Mapper
      extend self

      def from_response(id, source)
        favorite_page = FavoritePage.new source
        favorite_page.send 'id=', id
        favorite_page
      end
    end

    module ForPostQuery
      extend self

      def call(post)
        return [] if post.favorite_pages_query.blank?
        mapping = {favorite_page: Mapper.method(:from_response)}
        query = {
          query: {
            query_string: {
              query: post.favorite_pages_query,
              fields: %w[title^3 keywords^2 description^2 host url],
              lenient: true,
            }
          }
        }
        LowLevel::SearchQuery.call query, mapping
      end
    end

    module FindByIdQuery
      extend self

      def call(id, silent: false )
        LowLevel::FindByIdQuery.call :favorite_page, id, Mapper.method(:from_response), silent: silent
      end
    end

    module SaveCommand
      extend self

      def call(favorite_page)
        LowLevel::SaveCommand.call :favorite_page, favorite_page.id, favorite_page.attributes.except(:id)
      end
    end

    module DestroyCommand
      extend self

      def call(favorite_page)
        LowLevel::DestroyCommand.call :favorite_page, favorite_page.id
      end
    end
  end
end
