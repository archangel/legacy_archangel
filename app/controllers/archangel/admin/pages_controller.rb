module Archangel
  module Admin
    class PagesController < AdminController
      before_action :set_page, only: [:show, :new, :edit, :update, :destroy]
      before_action :set_breadcrumbs

      helper Archangel::Admin::PagesHelper

      def index
        @pages = Archangel::Page.all

        authorize @pages

        respond_with @pages
      end

      def show
        respond_with @page
      end

      def new
        respond_with @page
      end

      def edit
        respond_with @page
      end

      def create
        @page = Archangel::Page.new(page_params)

        authorize @page

        @page.save

        respond_with @page, location: -> { admin_pages_path }
      end

      def update
        @page.update(page_params)

        respond_with @page, location: -> { admin_pages_path }
      end

      def destroy
        @page.destroy

        respond_with @page, location: -> { admin_pages_path }
      end

      protected

      def permitted_attributes
        [
          :author_id, :content, :meta_description, :meta_keywords, :parent_id,
          :position, :published_at, :slug, :title
        ]
      end

      def page_params
        params.require(:page).permit(permitted_attributes)
      end

      def set_page
        if action_name.to_sym == :new
          @page = Archangel::Page.new
        else
          @page = Archangel::Page.find_by(id: params[:id])
        end

        authorize @page
      end

      def set_breadcrumbs
        add_breadcrumb Archangel.t(:dashboard, scope: :menu), admin_root_path
        add_breadcrumb Archangel.t(:pages, scope: :menu), admin_pages_path

        action = action_name.to_sym
        section_name = @page.class.name.split("::").last.humanize.titleize
        section_title = @page.title if [:show, :edit].include?(action)

        if action == :show
          add_breadcrumb(
            Archangel.t(:show_section, section: section_title, scope: :titles),
            admin_page_path(@page)
          )
        elsif action == :new
          add_breadcrumb(
            Archangel.t(:new_section, section: section_name, scope: :titles),
            new_admin_page_path
          )
        elsif action == :edit
          add_breadcrumb(
            Archangel.t(:edit_section, section: section_title, scope: :titles),
            edit_admin_page_path(@page)
          )
        end
      end
    end
  end
end
