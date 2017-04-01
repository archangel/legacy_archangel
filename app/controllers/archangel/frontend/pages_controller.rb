# frozen_string_literal: true

module Archangel
  module Frontend
    # Frontend pages controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class PagesController < FrontendController
      before_action :set_page

      helper Archangel::Frontend::PagesHelper

      # View a page
      #
      # = Request
      #   GET /:path
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [String] path - the page path
      #
      # = Response
      #   # Home page (301 redirects to / if the path is requested)
      #   {
      #     "id": 123,
      #     "title": "Home Page Title",
      #     "author_id": 123,
      #     "parent_id": null,
      #     "path": "home-page",
      #     "slug": "home-page",
      #     "homepage": true,
      #     "content": "<p>Home page content.</p>",
      #     "meta_keywords": "keywords, for, the, page",
      #     "meta_description": "Description of the page",
      #     "deleted_at": null,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      #   # Root level page
      #   {
      #     "id": 123,
      #     "title": "Page Title",
      #     "author_id": 123,
      #     "parent_id": null,
      #     "path": "page-path",
      #     "slug": "page-path",
      #     "homepage": false,
      #     "content": "<p>Page content.</p>",
      #     "meta_keywords": "keywords, for, the, page",
      #     "meta_description": "Description of the page",
      #     "deleted_at": null,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      #   # Nested page
      #   {
      #     "id": 123,
      #     "title": "Page Title",
      #     "author_id": 123,
      #     "parent_id": 123,
      #     "path": "parent-path/page-path",
      #     "slug": "page-path",
      #     "homepage": false,
      #     "content": "<p>Page content.</p>",
      #     "meta_keywords": "keywords, for, the, page",
      #     "meta_description": "Description of the page",
      #     "deleted_at": null,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        if redirect_to_homepage?
          return redirect_to root_path, status: :moved_permanently
        end

        respond_with @page
      end

      protected

      def set_page
        page_path = params.fetch(:path, nil)

        @page = page_path.nil? ? find_homepage : find_page(page_path)
      end

      def redirect_to_homepage?
        return false unless @page

        (params.fetch(:path, nil) == @page.path) && @page.homepage?
      end

      def find_homepage
        Archangel::Page.published.homepage.first!
      end

      def find_page(path)
        Archangel::Page.published.find_by!(path: path)
      end
    end
  end
end
