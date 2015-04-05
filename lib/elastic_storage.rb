module ElasticStorage
  NotFound = Class.new(StandardError)

  mattr_accessor(:low_level){ LowLevel }

  module_function

  def put_to_index(model)
    document = ModelToDocument.const_get(model.class.to_s, false).call model
    low_level.put_to_index model.model_name.singular, model.id, document
  end

  def delete_from_index(model)
    low_level.delete_from_index model.model_name.singular, model.id
  end

  def get(type, raw_id)
    id = raw_id.to_s.split('-').first
    document = low_level.get(type, id)
    "#{type}_view".camelcase.constantize.load(id, document)
  end

  # # posts
  #
  # def find_post_by_id_query
  #   PostType::FindByIdQuery
  # end
  #
  # def save_post_command
  #   PostType::SaveCommand
  # end
  #
  # def destroy_post_command
  #   PostType::DestroyCommand
  # end
  #
  # # favorite pages
  #
  # def find_favorite_page_by_id_query
  #   FavoritePageType::FindByIdQuery
  # end
  #
  # def save_favorite_page_command
  #   FavoritePageType::SaveCommand
  # end
  #
  # def destroy_favorite_page_command
  #   FavoritePageType::DestroyCommand
  # end
  #
  # # search
  #
  # def search_query
  #   SearchQuery
  # end
  #
  # def timeline_query
  #   TimelineQuery
  # end

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
