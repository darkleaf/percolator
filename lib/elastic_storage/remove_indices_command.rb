module ElasticStorage
  module RemoveIndicesCommand
    extend Client
    extend self

    def call
      client.indices.delete index: '_all'
    end
  end
end
