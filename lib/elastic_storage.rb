module ElasticStorage
  NotFound = Class.new(StandardError)

  mattr_accessor(:low_level){ LowLevel }

  module_function

  class << self
    delegate :create_index, :remove_index, :clear, :refresh_index, to: :low_level
  end

  def put_to_index(model, refresh: false)
    batch = Array.wrap(model).map do |m|
      document = ModelToDocument.const_get(m.class.to_s, false).call m
      { _type: m.model_name.singular, _id: m.id, data: document }
    end

    low_level.put batch, refresh: refresh
  end

  def delete_from_index(model, refresh: false)
    batch = Array.wrap(model).map do |m|
      { _type: m.model_name.singular, _id: m.id }
    end

    low_level.delete batch, refresh: refresh
  end

  def get(type, raw_id)
    id = raw_id.to_s.split('-').first
    document = low_level.get(type, id)
    "#{type}_view".camelcase.constantize.load(id, document)
  end
end
