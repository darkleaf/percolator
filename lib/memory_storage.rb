module MemoryStorage
  extend self
  @posts_storage = {}
  @pages_storage = {}

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

  def save_favorite_page
    ->(page) { @pages_storage[page.id] = page }
  end

  def find_favorite_page_by_id_query
    ->(id) { @pages_storage[id] }
  end

  def clear_command
    Proc.new do
      @posts_storage = {}
      @pages_storage = {}
    end
  end
end
