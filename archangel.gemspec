$:.push File.expand_path("../lib", __FILE__)

require "archangel/version"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "archangel"
  s.version     = Archangel::VERSION
  s.authors     = ["David Freerksen"]
  s.homepage    = "https://github.com/archangel/archangel"
  s.summary     = "Summary of Archangel."
  s.description = "Description of Archangel."
  s.license     = "MIT"

  s.files = Dir[
    "{app,config,db,lib}/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md"
  ]

  s.required_ruby_version = ">= 2.2.2"

  s.add_dependency "coffee-rails", ">= 4.2"
  s.add_dependency "jquery-rails", ">= 4.1"
  s.add_dependency "rails", ">= 5.0"
  s.add_dependency "sass-rails", ">= 5.0"
  s.add_dependency "uglifier", ">= 2.7"

  s.add_dependency "acts_as_list", "~> 0.7"
  s.add_dependency "acts_as_tree", "~> 2.4"
  s.add_dependency "animate-rails", "~> 1.0"
  s.add_dependency "bootstrap-sass", "~> 3.3"
  s.add_dependency "bootstrap3-datetimepicker-rails", "~> 4.17"
  s.add_dependency "carrierwave", "~> 0.11"
  s.add_dependency "date_validator", "~> 0.9"
  s.add_dependency "devise", "~> 4.1"
  s.add_dependency "devise_invitable", "~> 1.7"
  s.add_dependency "file_validators", "~> 2.1"
  s.add_dependency "font-awesome-rails", "~> 4.6"
  s.add_dependency "has_secure_token", "~> 1.0"
  s.add_dependency "highline", "~> 1.7"
  s.add_dependency "kaminari", "~> 0.17"
  s.add_dependency "local_time", "~> 1.0"
  s.add_dependency "mini_magick", "~> 4.5"
  s.add_dependency "momentjs-rails", "~> 2.11"
  s.add_dependency "paranoia", "~> 2.1"
  s.add_dependency "pundit", "~> 1.1"
  s.add_dependency "responders", "~> 2.2"
  s.add_dependency "select2-rails", "~> 4.0"
  s.add_dependency "simple_form", "~> 3.2"
  s.add_dependency "validates", "~> 1.0"

  s.add_development_dependency "capybara"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "database_cleaner", "~> 1.5"
  s.add_development_dependency "factory_girl_rails", "~> 4.7"
  s.add_development_dependency "launchy"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "rails-controller-testing", "~> 0.1"
  s.add_development_dependency "rspec-rails", "~> 3.5"
  s.add_development_dependency "shoulda-callback-matchers", "~> 1.1"
  s.add_development_dependency "shoulda-matchers", "~> 3.1"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "sqlite3"
end
