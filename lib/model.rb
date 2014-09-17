module Model
  extend ActiveSupport::Concern

  included do
    extend ActiveModel::Naming
    include Virtus.model
  end

  module ClassMethods
    # Load from storage without running initialize method
    def load_from_hash(params)
      obj = self.allocate
      attrs = params.clone
      id = attrs.delete :id
      obj.send "id=", id
      obj.attributes = attrs
      obj
    end
  end

  def to_key
    [id]
  end

  def to_param
    id
  end
end
