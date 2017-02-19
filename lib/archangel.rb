# frozen_string_literal: true

require "acts_as_list"
require "acts_as_tree"
require "bootstrap-sass"
require "bootstrap3-datetimepicker-rails"
require "carrierwave"
require "cocoon"
require "coffee-rails"
require "date_validator"
require "devise"
require "devise_invitable"
require "file_validators"
require "font-awesome-rails"
require "jquery-rails"
require "kaminari"
require "local_time"
require "mini_magick"
require "momentjs-rails"
require "paranoia"
require "pundit"
require "ransack"
require "responders"
require "sass-rails"
require "select2-rails"
require "simple_form"
require "validates"
require "uglifier"

require "archangel/engine"
require "archangel/configuration"
require "archangel/i18n"
require "archangel/languages"
require "archangel/menu_methods"
require "archangel/renderer/bootstrap"
require "archangel/roles"
require "archangel/settings"
require "archangel/version"

module Archangel
  class << self
    attr_accessor :configuration

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
