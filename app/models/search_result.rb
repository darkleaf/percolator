class SearchResult
  include Model

  attribute :id
  attribute :title
  attribute :published_at, DateTime
  attribute :highlighted_content
  attribute :type

  def to_s
    title
  end
end
