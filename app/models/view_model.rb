module ViewModel
  extend ActiveSupport::Concern

  included do
    extend ActiveModel::Naming
    include Virtus.model
  end

  module ClassMethods
    def load(id, document)
      allocate.tap{ |m| m.id = id }
              .tap{ |m| m.attributes = document }
    end
  end

  def to_key
    [id]
  end

  def to_param
    id
  end
end
