module PageIdGenerator
  extend self

  def generate_from_url(url)
    uri = UriNormalizer.normalized_uri_from_url url
    generate uri
  end

  def generate(uri)
    n_uri = UriNormalizer.normalized_uri uri
    Digest::MD5.hexdigest n_uri.to_s
  end
end
