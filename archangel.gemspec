$:.push File.expand_path("../lib", __FILE__)

require "archangel/version"

Gem::Specification.new do |s|
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

  s.add_dependency "rails", ">= 4.2.2"

  s.add_development_dependency "byebug"
  s.add_development_dependency "capybara", "~> 2.6"
  s.add_development_dependency "database_cleaner", "~> 1.5"
  s.add_development_dependency "factory_girl_rails", "~> 4.6"
  s.add_development_dependency "launchy"
  s.add_development_dependency "poltergeist", "~> 1.9"
  s.add_development_dependency "pry"
  s.add_development_dependency "rspec-rails", "~> 3.4"
  s.add_development_dependency "simplecov", "~> 0.11"
  s.add_development_dependency "sqlite3"
end
