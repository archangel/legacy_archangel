# frozen_string_literal: true

module Archangel
  module Admin
    # Admin categories controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class CategoriesController < AdminController
      before_action :set_categories, only: [:index]
      before_action :set_new_category, only: [:create, :new]
      before_action :set_category, only: [:destroy, :edit, :show, :update]
      before_action :set_autocomplete_categories, only: [:autocomplete]

      helper Archangel::Admin::CategoriesHelper

      # List of all categories
      #
      # = Request
      #   GET /admin/categories
      #   GET /admin/categories/page/:page
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] page - the page number
      #
      # = Response
      #   [
      #     {
      #       "id": 123,
      #       "name": "Category Name",
      #       "slug": "category-name",
      #       "description": "Description of the category",
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   ]
      #
      def index
        respond_with @categories
      end

      # View a category
      #
      # = Request
      #   GET /admin/categories/:slug
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [String] slug - the category slug
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "Category Name",
      #     "slug": "category-name",
      #     "description": "Description of the category",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @category
      end

      # New category
      #
      # = Request
      #   GET /admin/categories/new
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": null,
      #     "name": null,
      #     "slug": null,
      #     "description": null,
      #     "deleted_at": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @category
      end

      # Create a new category
      #
      # = Request
      #   POST /admin/categories
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "category": {
      #       "name": "Category Name",
      #       "slug": "category-name",
      #       "description": "Description of the category"
      #     }
      #   }
      #
      def create
        @category.save

        respond_with @category, location: -> { admin_categories_path }
      end

      # Edit a category
      #
      # = Request
      #   GET /admin/categories/:slug/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [String] slug - the category slug
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "Category Name",
      #     "slug": "category-name",
      #     "description": "Description of the category",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @category
      end

      # Update a category
      #
      # = Request
      #   PATCH /admin/categories/:slug
      #   PUT   /admin/categories/:slug
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [String] slug - the category slug
      #
      # = Request
      #   {
      #     "category": {
      #       "name": "Updated Category Name",
      #       "slug": "updated-category-name",
      #       "description": "Updated description of the category"
      #     }
      #   }
      #
      def update
        @category.update(category_params)

        respond_with @category, location: -> { admin_categories_path }
      end

      # Destroy a category
      #
      # This does not destroy the record. This only marks the category as
      # deleted
      #
      # = Request
      #   DELETE /admin/categories/:slug
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [String] slug - the category slug
      #
      def destroy
        @category.destroy

        respond_with @category, location: -> { admin_categories_path }
      end

      # Filtered list of categories
      #
      # = Request
      #   GET /admin/categories/autocomplete
      #   GET /admin/categories/autocomplete?q=[QUERY]
      #
      # = Formats
      #   JSON
      #
      # = Options
      #   [String] q - the query string
      #
      # = Response
      #   [
      #     {
      #       "id": 123,
      #       "name": "Category Name",
      #       "slug": "category-name",
      #       "description": "Description of the category",
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
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

        @query = Archangel::Category.ransack(description_or_name_cont: query)

        @categories = @query.result(distinct: true).order(:name).limit(25)

        authorize @categories
      end
    end
  end
end
