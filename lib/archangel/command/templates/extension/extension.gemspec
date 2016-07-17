$:.push File.expand_path("../lib", __FILE__)

require "<%= file_name %>/version"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "<%= file_name %>"
  s.version     = <%= class_name %>::VERSION
  s.authors     = ["Your Name"]
  s.homepage    = "https://github.com/[your-github-handle]/<%= file_name %>"
  s.summary     = "TODO: Summary of <%= class_name %>."
  s.description = "TODO: Description of <%= class_name %>."
  s.license     = "MIT"

  s.files = Dir[
    "{app,config,db,lib}/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md"
  ]

  s.required_ruby_version = ">= 2.2.2"

  s.add_dependency "archangel", "~> <%= archangel_version %>"

  s.add_development_dependency "capybara"
  s.add_development_dependency "coffee-rails"
  s.add_development_dependency "database_cleaner", "~> 1.5"
  s.add_development_dependency "factory_girl_rails", "~> 4.7"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "rails-controller-testing", "~> 0.1"
  s.add_development_dependency "rspec-rails", "~> 3.5"
  s.add_development_dependency "shoulda-callback-matchers", "~> 1.1"
  s.add_development_dependency "shoulda-matchers", "~> 3.1"
  s.add_development_dependency "sass-rails"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "sqlite3"
end
