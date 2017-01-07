source "https://rubygems.org"

gemspec

group :development do
  gem "brakeman", "~> 3.4.1"
  gem "reek", "~> 4.5.3"
  gem "rubocop", "~> 0.46.0"
  gem "scss_lint", "~> 0.52.0"
  gem "yard", "~> 0.9.5"
end

group :development, :test do
  gem "pry-byebug", "~> 3.4.2"
  gem "sqlite3", ">= 1.3.0",
    platforms: [:ruby, :mswin, :mswin64, :mingw, :x64_mingw]
end

group :test do
  gem "capybara", "~> 2.11.0"
  gem "coveralls", "~> 0.8.17"
  gem "database_cleaner", "~> 1.5.3"
  gem "factory_girl_rails", "~> 4.8.0"
  gem "launchy", "~> 2.4.3"
  gem "poltergeist", "~> 1.12.0"
  gem "rails-controller-testing", "~> 1.0.0"
  gem "rspec-rails", "~> 3.5.2"
  gem "shoulda-callback-matchers", "~> 1.1.4"
  gem "shoulda-matchers", "~> 3.1.1"
  gem "simplecov", "~> 0.12.0"
end
