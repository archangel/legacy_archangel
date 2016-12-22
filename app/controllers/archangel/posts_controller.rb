module Archangel
  class PostsController < ApplicationController
    before_action :set_posts, only: [:index]
    before_action :set_post, only: [:show]
    before_action :set_category_posts, only: [:category]
    before_action :set_tag_posts, only: [:tag]

    helper Archangel::PostsHelper

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

    def per_page
      params[:limit] || 12
    end

    def set_posts
      @posts = Archangel::Post.published
                              .in_year(params[:year] || nil)
                              .in_month(params[:month] || nil)
                              .page(params[:page])
                              .per(per_page)
    end

    def set_post
      path = [
        params[:year],
        params[:month],
        params[:slug]
      ].join("/")

      @post = Archangel::Post.published.find_by!(path: path)
    end

    def set_category_posts
      @category = Archangel::Category.find_by!(slug: params[:slug])
      @posts = Archangel::Post.published
                              .with_category(params[:slug])
                              .page(params[:page])
                              .per(per_page)
    end

    def set_tag_posts
      @tag = Archangel::Tag.find_by!(slug: params[:slug])
      @posts = Archangel::Post.published
                              .with_tag(params[:slug])
                              .page(params[:page])
                              .per(per_page)
    end
  end
end
