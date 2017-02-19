# frozen_string_literal: true

module Archangel
  module TestingSupport
    # Form helper test support
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    module FormHelpers
      def submit_form
        find("input[name='commit']").click
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::FormHelpers, type: :feature
end
