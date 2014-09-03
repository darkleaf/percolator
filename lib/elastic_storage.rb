module ElasticStorage
  extend self

  class NotFound < StandardError; end

  # posts

  def posts_by_date_query
    PostsByDateQuery
  end

  def find_post_by_id_query
    FindPostByIdQuery
  end

  def save_post_command
    SavePostCommand
  end

  def destroy_post_command
    DestroyPostCommand
  end

  # favorite pages

  def favorite_pages_by_date_query
    FavoritePagesByDateQuery
  end

  def find_favorite_page_by_id_query
    FindFavoritePageByIdQuery
  end

  def save_favorite_page_command
    SaveFavoritePageCommand
  end

  def destroy_favorite_page_command
    DestroyFavoritePageCommand
  end

  #indices

  def clear_command
    Service::ClearCommand
  end

  def create_indices_command
    Service::CreateIndicesCommand
  end

  def remove_indices_command
    Service::RemoveIndicesCommand
  end

  def put_mappings_command
    Service::PutMappingsCommand
  end
end
