module Archangel
  module Admin
    class CategoriesController < AdminController
      before_action :set_category, only: [:show, :new, :edit, :update, :destroy]

      helper Archangel::Admin::CategoriesHelper

      def index
        @categories = Archangel::Category.page(params[:page]).per(per_page)

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
          @category = Archangel::Category.find_by!(slug: params[:id])
        end

        authorize @category
      end
    end
  end
end
