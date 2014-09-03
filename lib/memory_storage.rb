module MemoryStorage
  extend self
  @posts_storage = {}
  @pages_storage = {}

  # posts
  def posts_by_date_query
    ->{ @posts_storage.values }
  end

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

  def favorite_pages_by_date_query
    ->{ @pages_storage.values }
  end

  def favorite_pages_for_post_query
    ->(_){ @pages_storage.values }
  end

  def find_favorite_page_by_id_query
    ->(id) { @pages_storage[id] }
  end

  def save_favorite_page_command
    ->(favorite_page) { @pages_storage[favorite_page.id] = favorite_page }
  end

  def destroy_favorite_page_command
    ->(favorite_page) { @pages_storage.delete favorite_page.id }
  end

  def clear_command
    Proc.new do
      @posts_storage = {}
      @pages_storage = {}
    end
  end
end
