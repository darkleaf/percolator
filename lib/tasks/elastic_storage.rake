namespace :elastic_storage do
  desc "Create indices"
  task create_indices: :environment do
    ElasticStorage.create_indices_command.call
  end

  desc "Put mappings"
  task put_mappings: :environment do
    ElasticStorage.put_mappings_command.call
  end

  desc "Put mappings"
  task prepare: [:create_indices, :put_mappings]
end
