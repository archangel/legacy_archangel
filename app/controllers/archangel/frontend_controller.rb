module Archangel
  # Frontend controller
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class FrontendController < ApplicationController
    helper Archangel::FrontendHelper

    protected

    def per_page_default
      12
    end

    def navigation_items
      Archangel::NavigationService.new(find_navigation).build
    end

    def find_navigation
      Archangel::Menu.includes_items.first
    end
  end
end
