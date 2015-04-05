namespace :elastic_storage do
  desc 'Create index'
  task create_index: :environment do
    ElasticStorage.create_index
    puts 'Index created'
  end

  desc 'Put mappings'
  task put_mappings: :environment do
    ElasticStorage.put_mappings
    puts 'Mappings uploaded'
  end

  desc 'Remove index'
  task remove_index: :environment do
    ElasticStorage.remove_index
    puts 'Index removed'
  end

  desc 'Index documents'
  task index: :environment do
    Post.index
    FavoritePage.index
  end

  desc 'Reindex'
  task reindex: %i[remove_index create_index put_mappings index]
end

Rake::Task["db:drop"].enhance do
  Rake::Task["elastic_storage:remove_index"].invoke
end

Rake::Task["db:create"].enhance do
  Rake::Task["elastic_storage:create_index"].invoke
  Rake::Task["elastic_storage:put_mappings"].invoke
end
