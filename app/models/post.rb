class Post
  include Virtus.model

  attribute :id, String, default: -> (_post, _attr) { SecureRandom.uuid }
  attribute :title, String
  attribute :content, String
end
