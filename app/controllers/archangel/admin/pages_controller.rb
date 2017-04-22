# frozen_string_literal: true

module Archangel
  module Admin
    # Admin pages controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class PagesController < AdminController
      before_action :set_pages, only: %i[index]
      before_action :set_new_page, only: %i[create new]
      before_action :set_page, only: %i[destroy edit show update]

      helper Archangel::Admin::PagesHelper

      def index
        respond_with @pages
      end

      def show
        respond_with @page
      end

      def new
        respond_with @page
      end

      def create
        @page.save

        respond_with @page, location: -> { admin_pages_path }
      end

      def edit
        respond_with @page
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
          :author_id, :content, :homepage, :meta_description, :parent_id,
          :published_at, :slug, :title,
          meta_keywords: [],
          category_ids: [],
          tag_ids: []
        ]
      end

      def page_params
        params.require(:page).permit(permitted_attributes)
      end

      def set_pages
        @pages = Archangel::Page.page(params[:page]).per(per_page)

        authorize @pages
      end

      def set_new_page
        new_params = action_name.to_sym == :create ? page_params : nil

        @page = Archangel::Page.new(new_params)

        authorize @page
      end

      def set_page
        @page = Archangel::Page.find_by!(id: params[:id])

        authorize @page
      end
    end
  end
end
