class FavoritePage
  extend ActiveModel::Naming
  include Virtus.model

  attribute :id, String, writer: :private
  attribute :url, String
  attribute :host, String, writer: :private
  attribute :title, String
  attribute :description, String
  attribute :keywords, String
  attribute :content, String
  attribute :published_at, DateTime, default: -> (_post, _attr) { DateTime.current }

  def url=(value)
    self.host = 'some_host.com'
    self.id = Digest::MD5.hexdigest value
    super
  end

  def to_key
    [id]
  end

  def to_param
    id
  end

  def to_s
    title
  end
end
