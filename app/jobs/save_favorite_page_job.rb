class SaveFavoritePageJob
  include SuckerPunch::Job
  include ServiceLocator

  def perform(url)
    source = open(url, "User-Agent" => "Mozilla/5.0").read
    attrs = DataExtractor.extract source
    attrs.merge! url: url

    page = FavoritePage.new attrs
    storage.save_favorite_page_command.call page
  end
end
