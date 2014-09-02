module ElasticStorage
  module FindPostByIdQuery
    extend self

    def call(id, silent: false )
      responce = FindByIdQuery.call id, :post, silent: silent
      return unless responce
      PostMapper.from_responce id, responce['_source']
    end
  end
end
