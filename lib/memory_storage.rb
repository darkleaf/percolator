module MemoryStorage
  extend self
  @posts_storage = {}
  @pages_storage = {}

  # posts

  def find_post_by_id_query
    ->(id) { @posts_storage[id] }
  end

  def save_post_command
    ->(post) { @posts_storage[post.id] = post }
  end

  def destroy_post_command
    ->(post) { @posts_storage.delete post.id }
  end

  #favorite pages

  def find_favorite_page_by_id_query
    ->(id) { @pages_storage[id] }
  end

  def save_favorite_page_command
    ->(favorite_page) { @pages_storage[favorite_page.id] = favorite_page }
  end

  def destroy_favorite_page_command
    ->(favorite_page) { @pages_storage.delete favorite_page.id }
  end

  # search

  def timeline_query
    models = @posts_storage.values | @pages_storage.values
    search_models = models.map do |m|
      type = m.class.model_name.singular
      Preview.new m.attributes.merge(type: type)
    end

    -> { search_models }
  end

  def search_query
    models = @posts_storage.values | @pages_storage.values
    search_models = models.map do |m|
      type = m.class.model_name.singular
      SearchResult.new m.attributes.merge(type: type)
    end

    ->(_) { search_models }
  end

  def clear_command
    Proc.new do
      @posts_storage = {}
      @pages_storage = {}
    end
  end
end
