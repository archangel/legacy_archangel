source "https://rubygems.org"

gemspec

group :development do
  gem "brakeman"
  gem "rubocop"
  gem "scss_lint"
end

group :development, :test do
  gem "pry-byebug", "~> 3.4"
  gem "sqlite3", "~> 1.3",
    platforms: [:ruby, :mswin, :mswin64, :mingw, :x64_mingw]
end

group :test do
  gem "capybara", "~> 2.8"
  gem "coveralls", "~> 0.8"
  gem "database_cleaner", "~> 1.5"
  gem "factory_girl_rails", "~> 4.7"
  gem "launchy", "~> 2.4"
  gem "poltergeist", "~> 1.10"
  gem "rails-controller-testing", "~> 1.0"
  gem "rspec-rails", "~> 3.5"
  gem "shoulda-callback-matchers", "~> 1.1"
  gem "shoulda-matchers", "~> 3.1"
  gem "simplecov", "~> 0.12"
end
