module ElasticStorage
  extend self

  class NotFound < StandardError; end

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

  def clear_command
    ClearCommand
  end

  def create_indices_command
    CreateIndicesCommand
  end

  def remove_indices_command
    RemoveIndicesCommand
  end

  def put_mappings_command
    PutMappingsCommand
  end
end
