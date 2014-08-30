FactoryGirl.define do
  factory :post do
    title
    content

    to_create { |post| ServiceLocator.storage.save_post_command.call post }
  end
end