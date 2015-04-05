module ElasticStorage
  NotFound = Class.new(StandardError)

  mattr_accessor(:low_level){ LowLevel }

  module_function

  class << self
    delegate :put_mappings,
             :remove_index,
             :create_index,
             :clear,
             to: :low_level
  end

  def put_to_index(model)
    document = ModelToDocument.const_get(model.class.to_s, false).call model
    low_level.put model.model_name.singular, model.id, document
  end

  def delete_from_index(model)
    low_level.delete model.model_name.singular, model.id
  end

  def get(type, raw_id)
    id = raw_id.to_s.split('-').first
    document = low_level.get(type, id)
    "#{type}_view".camelcase.constantize.load(id, document)
  end
end
