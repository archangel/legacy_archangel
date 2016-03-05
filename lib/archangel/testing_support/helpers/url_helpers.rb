module Archangel
  module TestingSupport
    module UrlHelpers
      def archangel
        Archangel::Engine.routes.url_helpers
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::UrlHelpers
end
