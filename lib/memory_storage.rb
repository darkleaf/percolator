module MemoryStorage
  extend self
  @state = {}

  def posts_by_date_query
    ->{ @state.values }
  end

  def find_post_by_id_query
    ->(id) { @state[id] }
  end

  def save_post_command
    ->(post) { @state[post.id] = post }
  end

  def destroy_post_command
    ->(post) { @state.delete post.id }
  end
end
