module Archangel
  module Admin
    class PagesController < AdminController
      before_action :set_page, only: [:show, :new, :edit, :update, :destroy]

      helper Archangel::Admin::PagesHelper

      def index
        @pages = Archangel::Page.page(params[:page]).per(per_page)

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
          :published_at, :slug, :title,
          category_ids: [],
          tag_ids: []
        ]
      end

      def page_params
        params.require(:page).permit(permitted_attributes)
      end

      def set_page
        if action_name.to_sym == :new
          @page = Archangel::Page.new
        else
          @page = Archangel::Page.find_by!(id: params[:id])
        end

        authorize @page
      end
    end
  end
end
