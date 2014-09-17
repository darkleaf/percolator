module ElasticStorage
  module PostType
    module Mapper
      extend self

      def from_response(hit)
        Post.load_from_hash hit._source.merge(id: hit._id)
      end
    end

    module FindByIdQuery
      extend self

      def call(id, silent: false )
        LowLevel::FindByIdQuery.call :post, id, Mapper.method(:from_response), silent: silent
      end
    end

    module SaveCommand
      extend self

      def call(post)
        LowLevel::SaveCommand.call :post, post.id, post.attributes.except(:id)
      end
    end

    module DestroyCommand
      extend self

      def call(post)
        LowLevel::DestroyCommand.call :post, post.id
      end
    end
  end
end
