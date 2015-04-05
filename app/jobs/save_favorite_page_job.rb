class SaveFavoritePageJob
  include SuckerPunch::Job

  def perform(url)
    source = open(url, "User-Agent" => "Mozilla/5.0").read
    attrs = DataExtractor.call source, url
    url_digest = UrlDigestGenerator.call url
    page = FavoritePage.find_or_initialize_by url_digest: url_digest
    page.update! attrs
  end
end
