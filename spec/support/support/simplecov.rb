require "simplecov"

SimpleCov.start :rails do
  add_filter "install_generator.rb"
  add_filter "version.rb"

  add_group "Modules", "app/modules"
  add_group "Services", "app/services"
end
