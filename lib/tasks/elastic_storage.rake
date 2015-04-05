namespace :elastic_storage do
  desc "Create indices"
  task create_indices: :environment do
    ElasticStorage.create_indices_command
  end

  desc "Put mappings"
  task put_mappings: :environment do
    ElasticStorage.put_mappings_command
  end

  desc "Remove indices"
  task remove_indices: :environment do
    ElasticStorage.remove_indices_command if agree("You lost you data! Remove indicies? (y/n)")
  end

  desc "Create indices and put mappings"
  task prepare: %i[create_indices put_mappings]

  desc "Reset indices and put mappings"
  task reset: %i[remove_indices create_indices put_mappings]
end
