module Archangel
  module Admin
    class DashboardsController < AdminController
      include Archangel::SkipAuthorizableConcern

      helper Archangel::Admin::DashboardsHelper

      def show
      end
    end
  end
end
