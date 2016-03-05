$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "archangel/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "archangel"
  s.version     = Archangel::VERSION
  s.authors     = ["David Freerksen"]
  s.email       = ["dfreerksen@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Archangel."
  s.description = "TODO: Description of Archangel."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5.2"

  s.add_development_dependency "sqlite3"
end
