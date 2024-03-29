# frozen_string_literal: true

require "active_link_to"
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
require "simple-navigation"
require "simple_form"
require "validates"
require "uglifier"

require "archangel/engine"
require "archangel/config"
require "archangel/i18n"
require "archangel/languages"
require "archangel/menu_methods"
require "archangel/renderer/bootstrap"
require "archangel/roles"
require "archangel/settings"
require "archangel/theme/themable_controller"
require "archangel/version"

# Archangel
#
# @author dfreerksen
# @since 0.0.1
#
module Archangel
  THEME_DIRECTORIES = [Archangel::Engine.root, Rails.root].freeze
  THEMES = Dir["app/themes/*/"].map { |dir| File.basename(dir) }.freeze
  THEME_DEFAULT = "default".to_s.freeze

  class << self
    attr_reader :config

    # Archangel configs
    #
    # = Example
    #  <% Archangel.contig.application %> #=> "archangel"
    #  <% Archangel.contiguration.application %> #=> "archangel"
    #
    def config
      @config ||= Config.new
    end
    alias configuration config

    # Archangel routes
    #
    # = Example
    #  <% Archangel.routes.root_path %> #=> "/"
    #  <% Archangel.routes.admin_root_path %> #=> "/admin"
    #
    def routes
      Archangel::Engine.routes.url_helpers
    end

    # Archangel themes
    #
    # = Example
    #  <% Archangel.themes %> #=> %i[default]
    #
    def themes
      [Archangel::THEME_DEFAULT] + Archangel::THEMES
    end
  end
end
