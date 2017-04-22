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

      # View site
      #
      # = Request
      #   GET /admin/site
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "Site Name",
      #     "locale": "en",
      #     "logo": {
      #       "url": "/path/to/logo.jpg",
      #       "medium": {
      #         "url": "/path/to/medium_logo.jpg"
      #       },
      #       "thumb": {
      #         "url": "/path/to/thumb_logo.jpg"
      #       },
      #       "mini": {
      #         "url": "/path/to/mini_logo.jpg"
      #       }
      #     },
      #     "meta_keywords": "site, keywords",
      #     "meta_description": "Site description",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "theme": "default",
      #     "favicon": null
      #   }
      #
      def show
        respond_with @site
      end

      # Edit site
      #
      # = Request
      #   GET /admin/site/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "Site Name",
      #     "locale": "en",
      #     "logo": {
      #       "url": "/path/to/logo.jpg",
      #       "medium": {
      #         "url": "/path/to/medium_logo.jpg"
      #       },
      #       "thumb": {
      #         "url": "/path/to/thumb_logo.jpg"
      #       },
      #       "mini": {
      #         "url": "/path/to/mini_logo.jpg"
      #       }
      #     },
      #     "meta_keywords": "site, keywords",
      #     "meta_description": "Site description",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "theme": "default",
      #     "favicon": null
      #   }
      #
      def edit
        respond_with @site
      end

      # Update site
      #
      # = Request
      #   PATCH /admin/site
      #   PUT   /admin/site
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "site": {
      #       "name": "Site Name",
      #       "locale": "en",
      #       "logo": "local/path/to/logo.jpg",
      #       "meta_keywords": "updated/site, keywords",
      #       "meta_description": "Updated site description",
      #       "theme": "default",
      #       "favicon": "local/path/to/favicon.ico"
      #     }
      #   }
      #
      def update
        @site.update(site_params)

        respond_with @site, location: -> { admin_site_path }
      end

      protected

      def permitted_attributes
        [
          :favicon, :locale, :logo, :meta_description, :name, :remove_favicon,
          :remove_logo, :theme,
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
