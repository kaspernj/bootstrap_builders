# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= "test"
require_relative "dummy/config/environment"
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"
# Add additional requires below this line. Rails is not loaded until this point!

require "cancancan"
require "devise"
require "factory_girl_rails"
require "haml"
require "simple_form"

ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.include Warden::Test::Helpers

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    Warden.test_mode!
  end

  config.before(:each) do
    Capybara.reset_sessions!
    Warden.test_reset!
  end
end
