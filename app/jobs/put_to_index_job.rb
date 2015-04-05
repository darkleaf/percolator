class PutToIndexJob
  include SuckerPunch::Job

  def perform(model)
    ElasticStorage.put_to_index(model)
  end
end
