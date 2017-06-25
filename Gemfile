# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "brakeman", "~> 3.6.1"
  gem "listen", "~> 3.1.5"
  gem "rails_best_practices", "~> 1.18.1"
  gem "reek", "~> 4.7.0"
  gem "rubocop", "~> 0.49.1"
  gem "scss_lint", "~> 0.54.0"
  gem "yard", "~> 0.9.9"
end

group :development, :test do
  gem "pry-byebug", "~> 3.4.2"
  gem "sqlite3", ">= 1.3.0", platforms: %i[ruby mswin mswin64 mingw x64_mingw]
end

group :test do
  gem "capybara", "~> 2.14.0"
  gem "coveralls", "~> 0.8.20"
  gem "database_cleaner", "~> 1.6.0"
  gem "factory_girl_rails", "~> 4.8.0"
  gem "launchy", "~> 2.4.3"
  gem "poltergeist", "~> 1.15.0"
  gem "rails-controller-testing", "~> 1.0.1"
  gem "rspec-rails", "~> 3.6.0"
  gem "shoulda-callback-matchers", "~> 1.1.4"
  gem "shoulda-matchers", "~> 3.1.1"
  gem "simplecov", "~> 0.14.1"
end
