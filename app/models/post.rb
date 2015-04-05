class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

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
end
