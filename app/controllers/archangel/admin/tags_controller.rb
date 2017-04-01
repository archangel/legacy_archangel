# frozen_string_literal: true

module Archangel
  module Admin
    # Admin tags controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class TagsController < AdminController
      before_action :set_tags, only: [:index]
      before_action :set_new_tag, only: [:create, :new]
      before_action :set_tag, only: [:destroy, :edit, :show, :update]
      before_action :set_autocomplete_tags, only: [:autocomplete]

      helper Archangel::Admin::TagsHelper

      # List of all tags
      #
      # = Request
      #   GET /admin/tags
      #   GET /admin/tags/page/:page
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
      #       "name": "Tag Name",
      #       "slug": "tag-name",
      #       "description": "Description of the tag",
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   ]
      #
      def index
        respond_with @tags
      end

      # View a tag
      #
      # = Request
      #   GET /admin/tags/:slug
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] slug - the tag slug
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "Tag Name",
      #     "slug": "tag-name",
      #     "description": "Description of the tag",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @tag
      end

      # New tag
      #
      # = Request
      #   GET /admin/tags/new
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
        respond_with @tag
      end

      # Create a new tag
      #
      # = Request
      #   POST /admin/tags
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "tag": {
      #       "name": "Tag Name",
      #       "slug": "tag-name",
      #       "description": "Description of the tag"
      #     }
      #   }
      #
      def create
        @tag.save

        respond_with @tag, location: -> { admin_tags_path }
      end

      # Edit a tag
      #
      # = Request
      #   GET /admin/tags/:slug/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] slug - the tag slug
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "Tag Name",
      #     "slug": "tag-name",
      #     "description": "Description of the tag",
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @tag
      end

      # Update a tag
      #
      # = Request
      #   PATCH /admin/tags/:slug
      #   PUT   /admin/tags/:slug
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] slug - the tag slug
      #
      # = Request
      #   {
      #     "tag": {
      #       "name": "Updated Tag Name",
      #       "slug": "updated-tag-name",
      #       "description": "Updated description of the tag"
      #     }
      #   }
      #
      def update
        @tag.update(tag_params)

        respond_with @tag, location: -> { admin_tags_path }
      end

      # Destroy a tag
      #
      # This does not destroy the record. This only marks the tag as
      # deleted
      #
      # = Request
      #   DELETE /admin/tags/:slug
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] slug - the tag slug
      #
      def destroy
        @tag.destroy

        respond_with @tag, location: -> { admin_tags_path }
      end

      # Filtered list of tags
      #
      # = Request
      #   GET /admin/tags/autocomplete
      #   GET /admin/tags/autocomplete?q=[QUERY]
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
      #       "name": "Tag Name",
      #       "slug": "tag-name",
      #       "description": "Description of the tag",
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def autocomplete
        respond_with @tags
      end

      protected

      def permitted_attributes
        [
          :description, :name, :slug
        ]
      end

      def tag_params
        params.require(:tag).permit(permitted_attributes)
      end

      def set_tags
        @tags = Archangel::Tag.page(params[:page]).per(per_page)

        authorize @tags
      end

      def set_new_tag
        new_params = action_name.to_sym == :create ? tag_params : nil

        @tag = Archangel::Tag.new(new_params)

        authorize @tag
      end

      def set_tag
        @tag = Archangel::Tag.find_by!(slug: params[:id])

        authorize @tag
      end

      def set_autocomplete_tags
        query = params.fetch(:q, "").to_s.strip

        @query = Archangel::Tag.ransack(description_or_name_cont: query)

        @tags = @query.result(distinct: true).order(:name).limit(25)

        authorize @tags
      end
    end
  end
end
