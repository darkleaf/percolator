namespace :elastic_storage do
  desc "Create index"
  task create_indices: :environment do
    ElasticStorage.create_index
  end

  desc "Put mappings"
  task put_mappings: :environment do
    ElasticStorage.put_mappings
  end

  desc "Remove index"
  task remove_indices: :environment do
    ElasticStorage.remove_index
  end

  desc "Create index and put mappings"
  task prepare: %i[create_indices put_mappings]

  desc "Reset index and put mappings"
  task reset: %i[remove_indices create_indices put_mappings]
end
