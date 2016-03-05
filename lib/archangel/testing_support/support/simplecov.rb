require "simplecov"

SimpleCov.start :rails do
  add_filter "dummy_generator.rb"
  add_filter "install_generator.rb"
  add_filter "version.rb"

  add_group "Inputs", "app/inputs"
  add_group "Modules", "app/modules"
  add_group "Policies", "app/policies"
  add_group "Services", "app/services"
  add_group "Uploaders", "app/uploaders"
end
