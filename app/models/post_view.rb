class PostView
  include ViewModel
  include CommonPostMethods

  attribute :id, String
  attribute :title, String
  attribute :content, String
  attribute :relative_query_without_self, String
  attribute :published_at
end
