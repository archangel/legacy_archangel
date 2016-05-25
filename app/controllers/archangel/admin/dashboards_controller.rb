module Archangel
  module Admin
    class DashboardsController < AdminController
      after_action :skip_authorization

      helper Archangel::Admin::DashboardsHelper

      def show
      end
    end
  end
end
