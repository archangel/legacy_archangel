# frozen_string_literal: true

module Archangel
  module Frontend
    # Frontend posts controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class PostsController < FrontendController
      before_action :set_posts, only: %i[index]
      before_action :set_post, only: %i[show]
      before_action :set_post_pager, only: %i[show]
      before_action :set_category_posts, only: %i[category]
      before_action :set_tag_posts, only: %i[tag]

      helper Archangel::Frontend::PostsHelper

      def index
        respond_with @posts
      end

      def show
        respond_with @post
      end

      def category
        respond_with @posts
      end

      def tag
        respond_with @posts
      end

      protected

      def set_posts
        @posts = Archangel::Post.published
                                .in_year(params[:year] || nil)
                                .in_month(params[:month] || nil)
                                .page(params[:page])
                                .per(per_page)
      end

      def set_post
        @post = Archangel::Post.published.find_by!(path: single_post_path)
      end

      def set_post_pager
        @previous = @post.previous
        @next = @post.next
      end

      def set_category_posts
        category_slug = params.fetch(:slug, "")

        @category = Archangel::Category.find_by!(slug: category_slug)
        @posts = Archangel::Post.published
                                .with_category(category_slug)
                                .page(params[:page])
                                .per(per_page)
      end

      def set_tag_posts
        tag_slug = params.fetch(:slug, "")

        @tag = Archangel::Tag.find_by!(slug: tag_slug)
        @posts = Archangel::Post.published
                                .with_tag(tag_slug)
                                .page(params[:page])
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
