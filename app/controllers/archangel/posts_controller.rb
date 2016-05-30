module Archangel
  class PostsController < ApplicationController
    before_action :set_post, only: :show

    helper Archangel::PostsHelper

    def index
      @posts = Archangel::Post.published
                              .in_year_and_month(params[:post_year],
                                                 params[:year_month])
                              .page(params[:page])
                              .per(per_page)

      if stale?(etag: @posts, last_modified: @posts.first.published_at)
        respond_with @posts
      end
    end

    def show
      if stale?(etag: @post, last_modified: @post.published_at)
        respond_with @post
      end
    end

    protected

    def set_post
      @post = Archangel::Post.published
                             .in_year_and_month(params[:post_year],
                                                params[:year_month])
                             .find_by!(slug: params[:month_id])
    end
  end
end
