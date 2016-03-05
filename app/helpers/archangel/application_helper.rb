module Archangel
  module ApplicationHelper
    include LocalTimeHelper

    def locale
      # TODO: This should be a configuration
      :en
    end
  end
end
