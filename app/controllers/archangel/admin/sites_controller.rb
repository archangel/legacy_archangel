module Archangel
  module Admin
    class SitesController < AdminController
      before_action :set_site

      def show
        respond_with @site
      end

      def edit
        respond_with @site
      end

      def update
        @site.update(site_params)

        respond_with @site, location: -> { admin_site_path }
      end

      protected

      def permitted_attributes
        [
          :title, :logo, :remove_logo
        ]
      end

      def set_site
        @site = current_site

        authorize @site
      end

      def site_params
        params.require(:site).permit(permitted_attributes)
      end
    end
  end
end
