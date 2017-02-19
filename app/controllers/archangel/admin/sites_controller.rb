# frozen_string_literal: true

module Archangel
  module Admin
    # Admin site controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class SitesController < AdminController
      before_action :set_site

      helper Archangel::Admin::SitesHelper

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
          :locale, :logo, :meta_description, :name, :remove_logo,
          meta_keywords: []
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
