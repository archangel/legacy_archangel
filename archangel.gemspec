$:.push File.expand_path("../lib", __FILE__)

require "archangel/version"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "archangel"
  s.version     = Archangel::VERSION
  s.authors     = ["David Freerksen"]
  s.email       = "dfreerksen@gmail.com"
  s.homepage    = "https://github.com/archangel/archangel"
  s.summary     = "Summary of Archangel."
  s.description = "Description of Archangel."
  s.license     = "MIT"

  s.files       = `git ls-files`.split($\)

  s.required_ruby_version = ">= 2.2.2"

  s.add_dependency "jquery-rails", ">= 4.1.0"
  s.add_dependency "rails", ">= 5.0", "< 5.1"
  s.add_dependency "sass-rails", ">= 5.0.0"
  s.add_dependency "uglifier", ">= 2.7"

  s.add_dependency "acts_as_list", "~> 0.9.1"
  s.add_dependency "acts_as_tree", "~> 2.6.1"
  s.add_dependency "bootstrap-sass", "~> 3.3.7"
  s.add_dependency "bootstrap3-datetimepicker-rails", "~> 4.17.43"
  s.add_dependency "carrierwave", "~> 1.0.0"
  s.add_dependency "cocoon", "~> 1.2.9"
  s.add_dependency "date_validator", "~> 0.9.0"
  s.add_dependency "devise", "~> 4.2.0"
  s.add_dependency "devise_invitable", "~> 1.7.0"
  s.add_dependency "file_validators", "~> 2.1.0"
  s.add_dependency "font-awesome-rails", "~> 4.7.0"
  s.add_dependency "highline", "~> 1.7.8"
  s.add_dependency "kaminari", "~> 1.0.1"
  s.add_dependency "local_time", "~> 1.0.3"
  s.add_dependency "mini_magick", "~> 4.6.0"
  s.add_dependency "momentjs-rails", "~> 2.17.1"
  s.add_dependency "paranoia", "~> 2.2.0"
  s.add_dependency "pundit", "~> 1.1.0"
  s.add_dependency "ransack", "~> 1.8.2"
  s.add_dependency "responders", "~> 2.3.0"
  s.add_dependency "select2-rails", "~> 4.0.3"
  s.add_dependency "simple-navigation", "~> 4.0.3"
  s.add_dependency "simple_form", "~> 3.4.0"
  s.add_dependency "validates", "~> 1.0.0"
end
