module Archangel
  class Engine < Rails::Engine
    isolate_namespace Archangel
    engine_name "archangel"

    require "responders"

    config.time_zone = :utc
    config.active_record.default_timezone = :utc

    config.action_controller.include_all_helpers = false

    config.responders.flash_keys = [:success, :error]

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: true,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
