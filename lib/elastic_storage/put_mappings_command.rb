module ElasticStorage
  module PutMappingsCommand
    extend Client
    extend self

    def call
      Settings.mappings.each do |type, mapping|
        client.indices.put_mapping index: :documents, type: type, body: { type => mapping }
      end
    end
  end
end
