# frozen_string_literal: true

module Archangel
  module Admin
    # Admin posts controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class PostsController < AdminController
      before_action :set_posts, only: [:index]
      before_action :set_new_post, only: [:create, :new]
      before_action :set_post, only: [:destroy, :edit, :show, :update]

      helper Archangel::Admin::PostsHelper

      # List of all posts
      #
      # = Request
      #   GET /admin/posts
      #   GET /admin/posts/page/:page
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
      #       "path": "YYYY/MM/post-title",
      #       "slug": "post-title",
      #       "author_id": 123,
      #       "content": "<p>Body of the post</p>",
      #       "meta_keywords": "keywords, for, the, post",
      #       "meta_description": "Description of the post",
      #       "feature": {
      #         "url": "/path/to/feature.jpg"
      #         "medium": {
      #           "url": "/path/to/medium_feature.jpg"
      #         },
      #         "thumb": {
      #           "url": "/path/to/thumb_feature.jpg"
      #        },
      #         "mini": {
      #           "url": "/path/to/mini_feature.jpg"
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
      #   GET /admin/posts/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the post ID
      #
      # = Response
      #   {
      #     "id": 123,
      #     "title": "Post Title",
      #     "path": "YYYY/MM/post-title",
      #     "slug": "post-title",
      #     "author_id": 123,
      #     "content": "<p>Body of the post</p>",
      #     "meta_keywords": "keywords, for, the, post",
      #     "meta_description": "Description of the post",
      #     "feature": {
      #       "url": "/path/to/feature.jpg"
      #       "medium": {
      #         "url": "/path/to/medium_feature.jpg"
      #       },
      #       "thumb": {
      #         "url": "/path/to/thumb_feature.jpg"
      #      },
      #       "mini": {
      #         "url": "/path/to/mini_feature.jpg"
      #       }
      #     },
      #     "deleted_at": null,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @post
      end

      # New post
      #
      # = Request
      #   GET /admin/posts/new
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": null,
      #     "title": null,
      #     "path": null,
      #     "slug": null,
      #     "author_id": null,
      #     "content": "",
      #     "meta_keywords": null,
      #     "meta_description": null,
      #     "feature": {
      #       "url": "/path/to/default_feature.jpg"
      #       "medium": {
      #         "url": "/path/to/medium_default_feature.jpg"
      #       },
      #       "thumb": {
      #         "url": "/path/to/thumb_default_feature.jpg"
      #      },
      #       "mini": {
      #         "url": "/path/to/mini_default_feature.jpg"
      #       }
      #     },
      #     "deleted_at": null,
      #     "published_at": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @post
      end

      # Create a new post
      #
      # = Request
      #   POST /admin/posts
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "post": {
      #       "title": "Post Title",
      #       "slug": "post-title",
      #       "author_id": 123,
      #       "content": "<p>Body of the post</p>",
      #       "meta_keywords": "keywords, for, the, post",
      #       "meta_description": "Description of the post",
      #       "feature": "/local/path/to/upload/feature.jpg",
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   }
      #
      def create
        @post.save

        respond_with @post, location: -> { admin_posts_path }
      end

      # Edit a post
      #
      # = Request
      #   GET /admin/posts/:id/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the post ID
      #
      # = Response
      #   {
      #     "id": 123,
      #     "title": "Post Title",
      #     "path": "YYYY/MM/post-title",
      #     "slug": "post-title",
      #     "author_id": 123,
      #     "content": "<p>Body of the post</p>",
      #     "meta_keywords": "keywords, for, the, post",
      #     "meta_description": "Description of the post",
      #     "feature": {
      #       "url": "/path/to/feature.jpg"
      #       "medium": {
      #         "url": "/path/to/medium_feature.jpg"
      #       },
      #       "thumb": {
      #         "url": "/path/to/thumb_feature.jpg"
      #      },
      #       "mini": {
      #         "url": "/path/to/mini_feature.jpg"
      #       }
      #     },
      #     "deleted_at": null,
      #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @post
      end

      # Update a post
      #
      # = Request
      #   PATCH /admin/posts/:id
      #   PUT   /admin/posts/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the post ID
      #
      # = Request
      #   {
      #     "post": {
      #       "title": "Updated Post Title",
      #       "slug": "updated-post-title",
      #       "author_id": 123,
      #       "content": "<p>Updated body of the post</p>",
      #       "meta_keywords": "updated, keywords, for, the, post",
      #       "meta_description": "Updated description of the post",
      #       "feature": "/local/path/to/upload/feature.jpg",
      #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     }
      #   }
      #
      def update
        @post.update(post_params)

        respond_with @post, location: -> { admin_posts_path }
      end

      # Destroy a post
      #
      # This does not destroy the record. This only marks the post as deleted
      #
      # = Request
      #   DELETE /admin/posts/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the post ID
      #
      def destroy
        @post.destroy

        respond_with @post, location: -> { admin_posts_path }
      end

      protected

      def permitted_attributes
        [
          :author_id, :content, :feature, :meta_description, :published_at,
          :remove_feature, :slug, :title,
          meta_keywords: [],
          category_ids: [],
          tag_ids: []
        ]
      end

      def post_params
        params.require(:post).permit(permitted_attributes)
      end

      def set_posts
        @posts = Archangel::Post.page(params[:page]).per(per_page)

        authorize @posts
      end

      def set_new_post
        new_params = action_name.to_sym == :create ? post_params : nil

        @post = Archangel::Post.new(new_params)

        authorize @post
      end

      def set_post
        @post = Archangel::Post.find_by!(id: params[:id])

        authorize @post
      end
    end
  end
end
