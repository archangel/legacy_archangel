# frozen_string_literal: true

require "rails/generators"
require "highline/import"
require "pry"

module Archangel
  module Generators
    # Theme generator
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class ThemeGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      class_option :theme_name, type: :string, desc: "Theme name"

      class_option :quiet, type: :boolean,
                           default: false,
                           desc: "Silence is golden"

      def prevent_nested_install
        return unless Rails.respond_to?(:root) && Rails.root.nil?

        abort "Theme generator cannot be run inside Archangel extension."
      end

      def copy_theme_template
        say_quietly "Creating theme..."

        empty_directory "app/themes/#{theme_name}"

        directory "assets", "app/themes/#{theme_name}/assets"
        directory "views", "app/themes/#{theme_name}/views"

        template "config/locales/en.yml",
                 "app/themes/#{theme_name}/config/locales/en.yml"
      end

      def banner
        say_quietly "*" * 80
        say_quietly "  Done, sir! Done! New Archangel theme named " \
                    "#{theme_name} has been created!"
        say_quietly "*" * 80
      end

      protected

      no_tasks do
        def theme_name
          theme = options[:theme_name] || "unknown theme"

          @theme_name = theme.parameterize(separator: "_")
        end

        def say_quietly(message)
          say message unless options[:quiet]
        end
      end
    end
  end
end
