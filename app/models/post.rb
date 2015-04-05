class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  after_commit :put_to_index, on: %i[create update]
  after_commit :delete_from_index, on: :destroy

  def relative_query_without_self
    return '' if relative_query.blank?
    "NOT (_id: #{id}) AND (#{relative_query})"
  end

  def to_param
    [id, title].join('-').parameterize
  end

  def to_s
    title
  end

  private
  def put_to_index
    PutToIndexJob.new.async.perform(self)
  end

  def delete_from_index
    DeleteFromIndexJob.new.async.perform(self)
  end
end
