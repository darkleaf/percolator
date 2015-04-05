FactoryGirl.define do
  factory :favorite_page do
    url
    url_digest { generate :string }
    title
    description
    keywords { 5.times.map{generate :string} }
    content
  end
end
