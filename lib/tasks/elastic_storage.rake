namespace :elastic_storage do
  desc "Create indices"
  task create_indices: :environment do
    ElasticStorage.create_indices_command.call
  end

  desc "Put mappings"
  task put_mappings: :environment do
    ElasticStorage.put_mappings_command.call
  end

  desc "Remove indices"
  task remove_indices: :environment do
    ElasticStorage.remove_indices_command.call
  end

  desc "Create indices and put mappings"
  task prepare: %i[remove_indices create_indices put_mappings]
end
