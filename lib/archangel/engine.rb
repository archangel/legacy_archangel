# frozen_string_literal: true

module Archangel
  # Archangel engine
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Engine < ::Rails::Engine
    isolate_namespace Archangel
    engine_name "archangel"

    require "responders"
    require "simple-navigation"

    SimpleNavigation.config_file_paths <<
      File.expand_path("../../../config", __FILE__)

    theme_dirs = [
      Archangel::Engine.root,
      Rails.root
    ]

    initializer "archangel.environment",
                before: :load_config_initializers do |app|
      app.config.archangel = Settings.new(config: %w(archangel))
    end

    initializer "archangel.load_locales" do |app|
      theme_dirs.each.each do |path|
        full_path = "#{path}/app/themes/*/locales/**/*.yml"

        Dir.glob(full_path).each { |dir| app.config.i18n.load_paths << dir }
      end
    end

    initializer "archangel.assets_path" do |app|
      theme_dirs.each.each do |path|
        full_path = "#{path}/app/themes/*/assets/*"

        Dir.glob(full_path).each { |dir| app.config.assets.paths << dir }
      end
    end

    initializer "archangel.precompile" do |app|
      app.config.assets.precompile << proc do |path, fn|
        if fn =~ %r{app/themes}
          if path =~ %r{/(admin|auth|frontend).(js|css)$}
            true
          else
            false
          end
        end
      end
    end

    config.action_controller.include_all_helpers = false

    config.generators do |gen|
      gen.test_framework :rspec,
                         fixtures: false,
                         view_specs: false,
                         helper_specs: true,
                         routing_specs: false,
                         controller_specs: true,
                         request_specs: true
      gen.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
