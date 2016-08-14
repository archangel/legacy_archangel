require "acts_as_list"
require "acts_as_tree"
require "animate-rails"
require "bootstrap-sass"
require "bootstrap3-datetimepicker-rails"
require "carrierwave"
require "coffee-rails"
require "date_validator"
require "devise"
require "devise_invitable"
require "file_validators"
require "font-awesome-rails"
require "has_secure_token"
require "jquery-rails"
require "kaminari"
require "local_time"
require "mini_magick"
require "momentjs-rails"
require "paranoia"
require "pundit"
require "responders"
require "sass-rails"
require "select2-rails"
require "simple_form"
require "tinymce-rails"
require "validates"
require "uglifier"

require "archangel/engine"
require "archangel/configuration"
require "archangel/i18n"
require "archangel/languages"
require "archangel/version"

module Archangel
  class << self
    attr_accessor :configuration

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new(load_configurations)
    end

    protected

    def configuration_paths
      %w(archangel)
    end

    def load_configurations
      configuration_paths.inject({}) do |configs, filename|
        configs.with_indifferent_access.deep_merge!(
          load_default_configuration(filename)
        )

        configs.with_indifferent_access.deep_merge!(
          load_application_configuration(filename)
        )
      end
    end

    def load_default_configuration(filename)
      load_configuration(Engine.root.join("config/#{filename}.yml"))
    end

    def load_application_configuration(filename)
      load_configuration(Rails.root.join("config/#{filename}.yml"))
    end

    def load_configuration(file_path)
      YAML.load_file(file_path)[Rails.env]
    rescue
      # TODO: Notify when file can't be loaded?
      {}
    end
  end
end
