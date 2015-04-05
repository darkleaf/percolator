class FavoritePageSearchView
  include ViewModel

  attribute :id, String
  attribute :url, String
  attribute :title, String
  attribute :highlighted_content, String
  attribute :published_at, DateTime

  def to_s
    title
  end
end
