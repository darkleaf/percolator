class FavoritePageView
  include ViewModel

  attribute :id, String
  attribute :url, String
  attribute :host, String
  attribute :title, String
  attribute :description, String
  attribute :keywords, Array[String]
  attribute :content, String
  attribute :published_at, DateTime

  def to_s
    title
  end

  def to_param
    [id, title].join('-').parameterize
  end
end
