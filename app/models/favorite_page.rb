class FavoritePage
  include Model

  attribute :id, String, writer: :private
  attribute :url, String
  attribute :host, String, writer: :private
  attribute :title, String
  attribute :description, String
  attribute :keywords, String
  attribute :content, String
  attribute :published_at, DateTime, default: -> (_post, _attr) { DateTime.current }

  def url=(value)
    uri = UriNormalizer.normalized_uri_from_url value
    self.host = uri.host
    self.id = PageIdGenerator.generate uri
    super
  end

  def to_s
    title
  end
end
