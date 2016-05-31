module Archangel
  module Admin
    class CategoriesController < AdminController
      before_action :set_category, only: [:show, :new, :edit, :update, :destroy]
      before_action :set_breadcrumbs

      helper Archangel::Admin::CategoriesHelper

      def index
        @categories = Archangel::Category.all

        authorize @categories

        respond_with @categories
      end

      def show
        respond_with @category
      end

      def new
        respond_with @category
      end

      def edit
        respond_with @category
      end

      def create
        @category = Archangel::Category.new(category_params)

        authorize @category

        @category.save

        respond_with @category, location: -> { admin_categories_path }
      end

      def update
        @category.update(category_params)

        respond_with @category, location: -> { admin_categories_path }
      end

      def destroy
        @category.destroy

        respond_with @category, location: -> { admin_categories_path }
      end

      protected

      def permitted_attributes
        [
          :description, :name, :slug
        ]
      end

      def category_params
        params.require(:category).permit(permitted_attributes)
      end

      def set_category
        if action_name.to_sym == :new
          @category = Archangel::Category.new
        else
          @category = Archangel::Category.find_by(slug: params[:id])
        end

        authorize @category
      end

      def set_breadcrumbs
        add_breadcrumb Archangel.t(:dashboard, scope: :menu), admin_root_path
        add_breadcrumb Archangel.t(:categories, scope: :menu),
                       admin_categories_path

        action = action_name.to_sym
        section_name = @category.class.name.split("::").last.humanize.titleize
        section_title = @category.name if [:show, :edit].include?(action)

        if action == :show
          add_breadcrumb(
            Archangel.t(:show_section, section: section_title, scope: :titles),
            admin_category_path(@category)
          )
        elsif action == :new
          add_breadcrumb(
            Archangel.t(:new_section, section: section_name, scope: :titles),
            new_admin_category_path
          )
        elsif action == :edit
          add_breadcrumb(
            Archangel.t(:edit_section, section: section_title, scope: :titles),
            edit_admin_category_path(@category)
          )
        end
      end
    end
  end
end
