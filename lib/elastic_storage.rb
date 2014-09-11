module ElasticStorage
  extend self

  class NotFound < StandardError; end

  # posts

  def find_post_by_id_query
    PostType::FindByIdQuery
  end

  def save_post_command
    PostType::SaveCommand
  end

  def destroy_post_command
    PostType::DestroyCommand
  end

  # favorite pages

  def find_favorite_page_by_id_query
    FavoritePageType::FindByIdQuery
  end

  def save_favorite_page_command
    FavoritePageType::SaveCommand
  end

  def destroy_favorite_page_command
    FavoritePageType::DestroyCommand
  end

  # search

  def search_query
    SearchQuery
  end

  def timeline_query
    TimelineQuery
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
