module Archangel
  module BaseHelper
    include LocalTimeHelper

    def locale
      # TODO: This should be a configuration
      :en
    end
  end
end
