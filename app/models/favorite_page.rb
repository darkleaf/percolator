class FavoritePage < ActiveRecord::Base
  include Indexable

  def host
    Addressable::URI.parse(url).host
  end
end
