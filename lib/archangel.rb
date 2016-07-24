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
require "simple_form"
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
      @configuration ||= Configuration.new(
        default_configurations.with_indifferent_access.deep_merge(load_config)
      )
    end

    protected

    def default_configurations
      {
        admin_path: "admin",
        auth_path: "account",
        application: "archangel",
        attachment_maximum_file_size: 2.megabytes
      }
    end

    protected

    def load_config
      YAML.load_file(Rails.root.join("config/archangel.yml"))[Rails.env]
     rescue
       # TODO: Notify when file can't be loaded?
       {}
    end
  end
end
