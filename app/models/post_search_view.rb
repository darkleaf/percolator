class PostSearchView
  include ViewModel
  include CommonPostMethods

  attribute :id, String
  attribute :title, String
  attribute :highlighted_content, String
  attribute :published_at, DateTime
end
