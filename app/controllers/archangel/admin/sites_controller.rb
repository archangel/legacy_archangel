module Archangel
  module Admin
    class SitesController < AdminController
      before_action :set_site
      before_action :set_breadcrumbs

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
          :title, :logo, :meta_keywords, :meta_description, :remove_logo
        ]
      end

      def set_site
        @site = current_site

        authorize @site
      end

      def site_params
        params.require(:site).permit(permitted_attributes)
      end

      def set_breadcrumbs
        add_breadcrumb Archangel.t(:dashboard, scope: :menu), admin_root_path
        add_breadcrumb Archangel.t(:site, scope: :menu), admin_site_path

        action = action_name.to_sym
        section_title = @site.title if [:edit].include?(action)

        if action == :edit
          add_breadcrumb(
            Archangel.t(:edit_section, section: section_title, scope: :titles),
            edit_admin_site_path
          )
        end
      end
    end
  end
end
