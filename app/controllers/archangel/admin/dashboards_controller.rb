module Archangel
  module Admin
    class DashboardsController < AdminController
      after_action :skip_authorization

      def show
      end
    end
  end
end
