require "simplecov"

SimpleCov.start :rails do
  add_filter "install_generator.rb"
  add_filter "version.rb"
end
