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
      #       "name": "My category name",
      #       "slug": "my-category-name",
      #       "description": "This is the description of the category"
      #     }
      #   ]
      #
      def index
        respond_with @categories
      end

      # View a category
      #
      # = Request
      #   GET /admin/categories/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the category ID
      #
      # = Response
      #   {
      #     "name": "My category name",
      #     "slug": "my-category-name",
      #     "description": "This is the description of the category"
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
      #     "name": "",
      #     "slug": "",
      #     "description": ""
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
      #       "name": "My category name",
      #       "slug": "my-category-name",
      #       "description": "This is the description of the category"
      #     }
      #   }
      #
      # = Response
      #   {
      #     "name": "My category name",
      #     "slug": "my-category-name",
      #     "description": "This is the description of the category"
      #   }
      #
      def create
        @category.save

        respond_with @category, location: -> { admin_categories_path }
      end

      # Edit a category
      #
      # = Request
      #   GET /admin/categories/:id/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "name": "My category name",
      #     "slug": "my-category-name",
      #     "description": "This is the description of the category"
      #   }
      #
      def edit
        respond_with @category
      end

      # Update a category
      #
      # = Request
      #   PATCH /admin/categories/:id
      #   PUT   /admin/categories/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "category": {
      #       "name": "My category name",
      #       "slug": "my-category-name",
      #       "description": "This is the description of the category"
      #     }
      #   }
      #
      # = Response
      #   {
      #     "name": "My category name",
      #     "slug": "my-category-name",
      #     "description": "This is the description of the category"
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
      #   DELETE /admin/categories/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the category ID
      #
      def destroy
        @category.destroy

        respond_with @category, location: -> { admin_categories_path }
      end

      # Filtered list of categories
      #
      # = Request
      #   GET /admin/categories/autocomplete
      #   GET /admin/categories/autocomplete?q=query
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
      #       "name": "My category name",
      #       "slug": "my-category-name",
      #       "description": "This is the description of the category"
      #     }
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
