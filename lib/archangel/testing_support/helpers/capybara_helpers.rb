module Archangel
  module TestingSupport
    module CapybaraHelpers
      def within_row(num, &block)
        if RSpec.current_example.metadata[:js]
          within("table.table tbody tr:nth-child(#{num})", &block)
        else
          within(:xpath, all("table.table tbody tr")[num-1].path, &block)
        end
      end
    end
  end
end

RSpec.configure do |config|
 config.include Archangel::TestingSupport::CapybaraHelpers, type: :feature
end
