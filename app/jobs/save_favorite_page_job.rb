class SaveFavoritePageJob
  include SuckerPunch::Job
  include ServiceLocator

  def perform(url)
    source = open(url).read
    attrs = DataExtractor.extract source
    attrs.merge! url: url

    page = FavoritePage.new attrs
    storage.save_favorite_page.call page
  end
end
