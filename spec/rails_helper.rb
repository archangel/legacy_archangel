ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../dummy/config/environment", __FILE__)

if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

require "spec_helper"
require "rspec/rails"

require "pry"
require "byebug"
require "launchy"

Dir[Rails.root.join("../support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.mock_with :rspec

  config.raise_errors_for_deprecations!
  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
end
