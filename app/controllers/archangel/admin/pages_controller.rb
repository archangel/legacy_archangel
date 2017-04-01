# frozen_string_literal: true

module Archangel
  module Admin
    # Admin pages controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class PagesController < AdminController
      before_action :set_pages, only: [:index]
      before_action :set_new_page, only: [:create, :new]
      before_action :set_page, only: [:destroy, :edit, :show, :update]

      helper Archangel::Admin::PagesHelper

      # List of all pages
      #
      # = Request
      #   GET /admin/pages
      #   GET /admin/pages/page/:page
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
      #       "title": "Page Title",
      #       "author_id": 123,
      #       "parent_id": null,
      #       "path": "foo/bar",
      #       "slug": "bar",
      #       "homepage": false,
      #       "content": "</p>Content of the page</p>",
      #       "meta_keywords": "keywords, for, the, page",
      #       "meta_description": "Description of the page",
      #       "deleted_at": null,
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @pages
      end

      # View a page
      #
      # = Request
      #   GET /admin/pages/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the page ID
      #
      # = Response
      #   {
      #     "id": 123,
      #     "title": "Page Title",
      #     "author_id": 123,
      #     "parent_id": null,
      #     "path": "foo/bar",
      #     "slug": "bar",
      #     "homepage": false,
      #     "content": "</p>Content of the page</p>",
      #     "meta_keywords": "keywords, for, the, page",
      #     "meta_description": "Description of the page",
      #     "deleted_at": null,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @page
      end

      # New page
      #
      # = Request
      #   GET /admin/pages/new
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": null,
      #     "title": null,
      #     "author_id": null,
      #     "parent_id": null,
      #     "slug": "",
      #     "homepage": false,
      #     "content": "",
      #     "meta_keywords": null,
      #     "meta_description": null,
      #     "deleted_at": null,
      #     "published_at": null
      #   }
      #
      def new
        respond_with @page
      end

      # Create a new page
      #
      # = Request
      #   POST /admin/pages
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "page": {
      #       "title": "Updated Page Title",
      #       "author_id": 123,
      #       "parent_id": null,
      #       "slug": "updated-slug",
      #       "homepage": false,
      #       "content": "</p>Updated content of the page</p>",
      #       "meta_keywords": "updated, keywords, for, the, page",
      #       "meta_description": "Updated description of the page",
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   }
      #
      def create
        @page.save

        respond_with @page, location: -> { admin_pages_path }
      end

      # Edit a page
      #
      # = Request
      #   GET /admin/pages/:id/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the page ID
      #
      # = Response
      #   {
      #     "id": 123,
      #     "title": "Page Title",
      #     "author_id": 123,
      #     "parent_id": null,
      #     "path": "foo/bar",
      #     "slug": "bar",
      #     "homepage": false,
      #     "content": "</p>Content of the page</p>",
      #     "meta_keywords": "keywords, for, the, page",
      #     "meta_description": "Description of the page",
      #     "deleted_at": null,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @page
      end

      # Update a page
      #
      # = Request
      #   PATCH /admin/pages/:id
      #   PUT   /admin/pages/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the page ID
      #
      # = Request
      #   {
      #     "page": {
      #       "title": "Updated Page Title",
      #       "author_id": 123,
      #       "parent_id": null,
      #       "slug": "updated-slug",
      #       "homepage": false,
      #       "content": "</p>Updated content of the page</p>",
      #       "meta_keywords": "updated, keywords, for, the, page",
      #       "meta_description": "Updated description of the page",
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   }
      #
      def update
        @page.update(page_params)

        respond_with @page, location: -> { admin_pages_path }
      end

      # Destroy a page
      #
      # This does not destroy the record. This only marks the page as deleted
      #
      # = Request
      #   DELETE /admin/pages/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the page ID
      #
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
