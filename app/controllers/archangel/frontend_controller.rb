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
      proc do |primary|
        primary.dom_attributes = { class: "nav navbar-nav" }

        primary.item :home, Archangel.t(:home, scope: :menu), root_path
      end
    end
  end
end
