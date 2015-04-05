module Indexable
  extend ActiveSupport::Concern

  included do
    after_commit :put_to_index, on: %i[create update]
    after_commit :delete_from_index, on: :destroy
  end

  module ClassMethods
    def index
      find_in_batches batch_size: 100 do |batch|
        ElasticStorage.put_to_index batch
      end
    end
  end

  private
  def put_to_index
    PutToIndexJob.new.async.perform(self)
  end

  def delete_from_index
    DeleteFromIndexJob.new.async.perform(self)
  end
end
