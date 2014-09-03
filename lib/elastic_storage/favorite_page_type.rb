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

    module ByDateQuery
      extend self

      def call
        mapping = {favorite_page: Mapper.method(:from_response)}
        query = {sort: { published_at: { order: :desc }}}
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
