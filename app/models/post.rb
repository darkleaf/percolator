class Post
  include Virtus.model

  attribute :id, String, writer: :private, default: -> (_post, _attr) { SecureRandom.uuid }
  attribute :title, String
  attribute :content, String
  attribute :published_at, DateTime, default: -> (_post, _attr) { DateTime.current }
end
