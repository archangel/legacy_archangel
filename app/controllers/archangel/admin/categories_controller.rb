module Archangel
  module Admin
    class CategoriesController < AdminController
      before_action :set_categories, only: [:index]
      before_action :set_new_category, only: [:create, :new]
      before_action :set_category, only: [:destroy, :edit, :show, :update]
      before_action :set_autocomplete_categories, only: [:autocomplete]

      helper Archangel::Admin::CategoriesHelper

      def index
        respond_with @categories
      end

      def show
        respond_with @category
      end

      def new
        respond_with @category
      end

      def create
        @category.save

        respond_with @category, location: -> { admin_categories_path }
      end

      def edit
        respond_with @category
      end

      def update
        @category.update(category_params)

        respond_with @category, location: -> { admin_categories_path }
      end

      def destroy
        @category.destroy

        respond_with @category, location: -> { admin_categories_path }
      end

      def autocomplete
        respond_with @categories
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

      def set_categories
        @categories = Archangel::Category.page(params[:page]).per(per_page)

        authorize @categories
      end

      def set_new_category
        new_params = action_name.to_sym == :create ? category_params : nil

        @category = Archangel::Category.new(new_params)

        authorize @category
      end

      def set_category
        @category = Archangel::Category.find_by!(slug: params[:id])

        authorize @category
      end

      def set_autocomplete_categories
        query = params.fetch(:q, "").to_s.strip

        @q = Archangel::Category.ransack(description_or_name_cont: query)

        @categories = @q.result(distinct: true).order(:name).limit(25)

        authorize @categories
      end
    end
  end
end
