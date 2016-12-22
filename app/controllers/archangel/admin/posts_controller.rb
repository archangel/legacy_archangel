module Archangel
  module Admin
    class PostsController < AdminController
      before_action :set_posts, only: [:index]
      before_action :set_new_post, only: [:create, :new]
      before_action :set_post, only: [:destroy, :edit, :show, :update]

      helper Archangel::Admin::PostsHelper

      def index
        respond_with @posts
      end

      def show
        respond_with @post
      end

      def new
        respond_with @post
      end

      def edit
        respond_with @post
      end

      def create
        @post.save

        respond_with @post, location: -> { admin_posts_path }
      end

      def update
        @post.update(post_params)

        respond_with @post, location: -> { admin_posts_path }
      end

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
