class DeleteFromIndexJob
  include SuckerPunch::Job

  def perform(post)
    ElasticStorage.delete_from_index(post)
  end
end
