class SearchResult
  include Model

  attribute :id
  attribute :title
  attribute :published_at, DateTime
  attribute :highlighted_content
  attribute :type

  delegate :url_helpers, to: 'Rails.application.routes'

  def path(opts={})
    url_helpers.send "#{type}_path", id, opts
  end

  def to_s
    title
  end
end
