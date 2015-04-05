class PostView
  include ViewModel

  attribute :id, String
  attribute :title, String
  attribute :content, String
  attribute :relative_query_without_self, String
  attribute :published_at, DateTime, default: -> (_post, _attr) { DateTime.current }

  def to_s
    title
  end

  def to_param
    [id, title].join('-').parameterize
  end
end
