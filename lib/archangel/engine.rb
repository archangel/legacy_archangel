# frozen_string_literal: true

module Archangel
  class Engine < ::Rails::Engine
    isolate_namespace Archangel
    engine_name "archangel"

    require "responders"

    config.action_controller.include_all_helpers = false

    initializer "archangel.environment",
                before: :load_config_initializers do |app|
      app.config.archangel = Settings.new(config: %w(archangel))
    end

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
