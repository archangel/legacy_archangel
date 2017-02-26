# frozen_string_literal: true

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
      menu = Archangel::Menu.first
      items = Archangel::MenuItem.includes(:menuable).where(menu: menu)

      Archangel::NavigationService.new(menu, items).build
    end
  end
end
