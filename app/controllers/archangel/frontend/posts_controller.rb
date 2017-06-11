# frozen_string_literal: true

module Archangel
  module Frontend
    # Frontend posts controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class PostsController < FrontendController
      before_action :set_posts, only: [:index]
      before_action :set_post, only: [:show]
      before_action :set_category_posts, only: [:category]
      before_action :set_tag_posts, only: [:tag]

      helper Archangel::Frontend::PostsHelper

      # List of all posts
      #
      # = Request
      #   GET /posts
      #   GET /posts/page/:page
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
      #       "title": "Post Title",
      #       "path": "YYYY/MM/post-slug",
      #       "slug": "post-slug",
      #       "author_id": 123,
      #       "content": "<p>Post content</p>",
      #       "meta_keywords": "keywords, for, the, post",
      #       "meta_description": "Description of the post",
      #       "feature": {
      #         "url": "/path/to/uploaded/feature.jpg",
      #         "medium": {
      #           "url": "/path/to/uploaded/medium_feature.jpg"
      #         },
      #         "thumb": {
      #           "url": "/path/to/uploaded/thumb_feature.jpg"
      #         },
      #         "mini": {
      #           "url": "/path/to/uploaded/mini_feature.jpg"
      #         }
      #       },
      #       "deleted_at": null,
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @posts
      end

      # View a post
      #
      # = Request
      #   GET /posts/:yyyy/:mm/:slug
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] yyyy - the published year
      #   [Integer] mm - the published month
      #   [String] slug - the page slug
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
        respond_with @post
      end

      # List of all posts by category
      #
      # = Request
      #   GET /posts/category/:slug
      #   GET /posts/category/:slug/page/:page
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [String] slug - the category slug
      #   [Integer] page - the page number
      #
      # = Response
      #   [
      #     {
      #       "id": 123,
      #       "title": "Post Title",
      #       "path": "YYYY/MM/post-slug",
      #       "slug": "post-slug",
      #       "author_id": 123,
      #       "content": "<p>Post content</p>",
      #       "meta_keywords": "keywords, for, the, post",
      #       "meta_description": "Description of the post",
      #       "feature": {
      #         "url": "/path/to/uploaded/feature.jpg",
      #         "medium": {
      #           "url": "/path/to/uploaded/medium_feature.jpg"
      #         },
      #         "thumb": {
      #           "url": "/path/to/uploaded/thumb_feature.jpg"
      #         },
      #         "mini": {
      #           "url": "/path/to/uploaded/mini_feature.jpg"
      #         }
      #       },
      #       "deleted_at": null,
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def category
        respond_with @posts
      end

      # List of all posts by tag
      #
      # = Request
      #   GET /posts/tag/:slug
      #   GET /posts/tag/:slug/page/:page
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [String] slug - the tag slug
      #   [Integer] page - the page number
      #
      # = Response
      #   [
      #     {
      #       "id": 123,
      #       "title": "Post Title",
      #       "path": "YYYY/MM/post-slug",
      #       "slug": "post-slug",
      #       "author_id": 123,
      #       "content": "<p>Post content</p>",
      #       "meta_keywords": "keywords, for, the, post",
      #       "meta_description": "Description of the post",
      #       "feature": {
      #         "url": "/path/to/uploaded/feature.jpg",
      #         "medium": {
      #           "url": "/path/to/uploaded/medium_feature.jpg"
      #         },
      #         "thumb": {
      #           "url": "/path/to/uploaded/thumb_feature.jpg"
      #         },
      #         "mini": {
      #           "url": "/path/to/uploaded/mini_feature.jpg"
      #         }
      #       },
      #       "deleted_at": null,
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def tag
        respond_with @posts
      end

      protected

      def set_posts
        @posts = Archangel::Post.published
                                .in_year(params[:year] || nil)
                                .in_month(params[:month] || nil)
                                .page(page_num)
                                .per(per_page)
      end

      def set_post
        @post = Archangel::Post.published.find_by!(path: single_post_path)
      end

      def set_category_posts
        category_slug = params.fetch(:slug, "")

        @category = Archangel::Category.find_by!(slug: category_slug)
        @posts = Archangel::Post.published
                                .with_category(category_slug)
                                .page(page_num)
                                .per(per_page)
      end

      def set_tag_posts
        tag_slug = params.fetch(:slug, "")

        @tag = Archangel::Tag.find_by!(slug: tag_slug)
        @posts = Archangel::Post.published
                                .with_tag(tag_slug)
                                .page(page_num)
                                .per(per_page)
      end

      def single_post_path
        [
          params[:year],
          params[:month],
          params[:slug]
        ].join("/")
      end
    end
  end
end
