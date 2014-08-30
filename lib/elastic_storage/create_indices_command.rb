module ElasticStorage
  module CreateIndicesCommand
    extend Client
    extend self

    def call
      client.indices.create index: :documents, body: { settings: Settings.settings }
    end
  end
end
