class Postdf
  include Model

  attribute :id, String, writer: :private, default: -> (_post, _attr) { SecureRandom.uuid }
  attribute :title, String
  attribute :content, String
  #TODO: rename this
  attribute :favorite_pages_query, String
  attribute :published_at, DateTime, default: -> (_post, _attr) { DateTime.current }

  def to_s
    title
  end

  def similar_query
    return '' if favorite_pages_query.blank?
    "NOT (_id: #{id}) AND (#{favorite_pages_query})"
  end
end
