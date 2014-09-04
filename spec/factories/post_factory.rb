FactoryGirl.define do
  factory :post do
    title
    content
    favorite_pages_query { generate :string }

    to_create { |post| ServiceLocator.storage.save_post_command.call post }
  end
end
