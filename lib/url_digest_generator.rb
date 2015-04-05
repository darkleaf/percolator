module UrlDigestGenerator
  module_function

  def call(url)
    uri = UriNormalizer.normalized_uri_from_url url
    Digest::MD5.hexdigest uri.to_s
  end
end
