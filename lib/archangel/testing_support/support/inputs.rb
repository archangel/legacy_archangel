# frozen_string_literal: true

module Archangel
  module TestingSupport
    # Input helper support for type: input
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    module InputExampleGroup
      extend ActiveSupport::Concern

      include RSpec::Rails::HelperExampleGroup

      def input_for(object, attribute_name, options = {})
        helper.simple_form_for object, url: "" do |f|
          f.input attribute_name, options
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::InputExampleGroup, type: :input
end
