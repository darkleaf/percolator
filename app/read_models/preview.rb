class Preview
  include Model

  attribute :id
  attribute :title
  attribute :published_at, DateTime
  attribute :type

  def to_s
    title
  end
end
