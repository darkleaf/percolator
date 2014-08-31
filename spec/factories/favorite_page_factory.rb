FactoryGirl.define do
  factory :favorite_page do
    url
    title
    description
    keywords { 5.times.map{generate :string}.join(',') }
    content

    to_create { |page| ServiceLocator.storage.save_favorite_page_command.call page }
  end
end
