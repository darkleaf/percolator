module UriNormalizer
  extend self

  def normalized_uri_from_url(url)
    uri = Addressable::URI.parse(url)
    normalized_uri uri
  end

  def normalized_uri(uri)
    uri.omit(:fragment).normalize
  end
end
