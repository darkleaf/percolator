# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'sucker_punch/testing/inline'
require 'webmock/rspec'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

WebMock.disable_net_connect!(allow_localhost: true, allow: 'codeclimate.com')

RSpec.configure do |config|
  config.include ServiceLocator
  config.include FactoryGirl::Syntax::Methods

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!


  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end


  config.before :suite do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)

    ElasticStorage.remove_indices_command.call
    ElasticStorage.create_indices_command.call
    ElasticStorage.put_mappings_command.call
  end

  config.after :suite do
    ElasticStorage.remove_indices_command.call
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
    storage.clear_command.call
  end
end

def fixture_file_path(name)
  File.join(Dir.pwd, 'spec', 'fixtures', name)
end

def sign_in
  post "/session", session: {password: Figaro.env.password}
end
