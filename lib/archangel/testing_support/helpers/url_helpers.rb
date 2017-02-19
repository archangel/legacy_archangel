# frozen_string_literal: true

module Archangel
  module TestingSupport
    # URL helper test support
    #
    # @author dfreerksen
    # @since 0.0.1
    #
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
