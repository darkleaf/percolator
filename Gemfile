source 'https://rubygems.org'
ruby "2.1.2"

gem 'rails', '4.1.5'

gem 'uglifier', '>= 1.3.0'
gem 'therubyracer',  platforms: :ruby

gem 'sass-rails', '~> 4.0.3'
gem 'jquery-rails'
gem 'haml'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'codemirror-rails'

gem 'virtus'
gem 'hashie'
gem 'elasticsearch'

gem 'sucker_punch'
gem 'unicorn'
gem 'figaro'

gem 'highline', require: 'highline/import'

gem 'simple_form', github: 'plataformatec/simple_form'

gem 'redcarpet'
gem 'meta-tags'

gem 'kaminari'
gem 'bootstrap-kaminari-views'

gem 'ruby-readability'
gem 'addressable', require: %w[addressable/uri]

gem 'rack-google-analytics'

group :production do
  gem 'rails_12factor'
end

gem 'newrelic_rpm'
gem 'rollbar'

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
end

group :development do
  gem 'spring'
  gem 'foreman'
end

group :test do
  gem "codeclimate-test-reporter", require: nil
  gem 'factory_girl_rails'
  gem 'factory_girl_sequences'
  gem 'webmock'
end
