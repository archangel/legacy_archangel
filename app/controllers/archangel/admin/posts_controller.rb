module Archangel
  module Admin
    class PostsController < AdminController
      before_action :set_post, only: [:show, :new, :edit, :update, :destroy]
      before_action :set_associations, only: [:new, :edit, :create, :update]
      before_action :set_breadcrumbs

      helper Archangel::Admin::PostsHelper

      def index
        @posts = Archangel::Post.page(params[:page]).per(per_page)

        authorize @posts

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
        @post = Archangel::Post.new(post_params)

        authorize @post

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
          :author_id, :banner, :content, :excerpt, :published_at,
          :remove_banner, :slug, :title,
          category_ids: [], tag_ids: []
        ]
      end

      def post_params
        params.require(:post).permit(permitted_attributes)
      end

      def set_post
        if action_name.to_sym == :new
          @post = Archangel::Post.new
        else
          @post = Archangel::Post.find_by(id: params[:id])
        end

        authorize @post
      end

      def set_associations
        @categories = Archangel::Category.all.map { |c| [c.name, c.id] }
        @tags = Archangel::Tag.all.map { |t| [t.name, t.id] }
      end

      def set_breadcrumbs
        add_breadcrumb Archangel.t(:dashboard, scope: :menu), admin_root_path
        add_breadcrumb Archangel.t(:posts, scope: :menu), admin_posts_path

        action = action_name.to_sym
        section_name = @post.class.name.split("::").last.humanize.titleize
        section_title = @post.title if [:show, :edit].include?(action)

        if action == :show
          add_breadcrumb(
            Archangel.t(:show_section, section: section_title, scope: :titles),
            admin_post_path(@post)
          )
        elsif action == :new
          add_breadcrumb(
            Archangel.t(:new_section, section: section_name, scope: :titles),
            new_admin_post_path
          )
        elsif action == :edit
          add_breadcrumb(
            Archangel.t(:edit_section, section: section_title, scope: :titles),
            edit_admin_post_path(@post)
          )
        end
      end
    end
  end
end
