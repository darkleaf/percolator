class Post < ActiveRecord::Base
  include Indexable
  include CommonPostMethods

  validates :title, presence: true
  validates :content, presence: true

  def relative_query_without_self
    return '' if relative_query.blank?
    "NOT (_id: #{id}) AND (#{relative_query})"
  end
end
