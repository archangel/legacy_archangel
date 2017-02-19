# frozen_string_literal: true

module Archangel
  module Admin
    # Admin dashboard controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class DashboardsController < AdminController
      include Archangel::SkipAuthorizableConcern

      helper Archangel::Admin::DashboardsHelper

      # View dashboard
      #
      # = Request
      #   GET /admin
      #
      # = Formats
      #   HTML, JSON
      #
      def show; end
    end
  end
end
