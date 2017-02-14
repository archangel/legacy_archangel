module Archangel
  # Frontend controller
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class FrontendController < ApplicationController
    helper Archangel::FrontendHelper

    protected

    def per_page
      params.fetch(:limit, 12)
    end

    def navigation_items
      navigation = Archangel::Navigation.new

      navigation.build
    end
  end
end
