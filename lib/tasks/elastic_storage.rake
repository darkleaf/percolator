namespace :elastic_storage do
  desc 'Create index'
  task create_index: :environment do
    ElasticStorage.create_index
  end

  desc 'Put mappings'
  task put_mappings: :environment do
    ElasticStorage.put_mappings
  end

  desc 'Remove index'
  task remove_index: :environment do
    ElasticStorage.remove_index
  end

  desc 'Index documents'
  task index: :environment do
    Post.index
    FavoritePage.index
  end

  desc 'Reindex'
  task reindex: %i[remove_index create_index put_mappings index]
end
