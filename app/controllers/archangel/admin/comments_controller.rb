module Archangel
  module Admin
    class CommentsController < AdminController
      before_action :set_source
      before_action :set_comment, only: [:edit, :update, :destroy]
      before_action :set_breadcrumbs

      helper Archangel::Admin::CommentsHelper

      def index
        @comments = Archangel::Comment.for_source(@source)
                                      .page(params[:page])
                                      .per(per_page)

        authorize @comments

        respond_with @comments
      end

      def edit
        respond_with @comment
      end

      def update
        @comment.update(comment_params)

        respond_with @comment, location: -> { source_path }
      end

      def destroy
        @comment.destroy

        respond_with @comment, location: -> { source_path }
      end

      protected

      def set_source
        # klass = commentable_models.detect{ |c| params[class_name_for(c)] }
        #
        # @source = klass.find(params[class_name_for(klass)])
        @source = case
          when params[:post_id] then Archangel::Post.find(params[:post_id])
        end
      end

      # def commentable_models
      #   %w[post]
      # end

      def source_path
        case
          when params[:post_id] then admin_post_comments_path(@source)
        end
      end

      # def class_name_for(object)
      #   "#{object.name.split("::").last.underscore}_id"
      # end

      def set_comment
        if action_name.to_sym == :new
          @comment = Archangel::Comment.new
        else
          @comment = Archangel::Comment.for_source(@source)
                                       .find(params[:id])
        end

        authorize @comment
      end

      def permitted_attributes
        [
          :approved_at, :author_id, :commentable, :content, :email, :name,
          :parent_id
        ]
      end

      def comment_params
        params.require(:comment).permit(permitted_attributes)
      end

      def set_breadcrumbs
        add_breadcrumb Archangel.t(:dashboard, scope: :menu), admin_root_path
        add_breadcrumb Archangel.t(:posts, scope: :menu), admin_posts_path

        action = action_name.to_sym
        section_title = @source.title

        add_breadcrumb section_title, admin_post_path(@source)
        add_breadcrumb Archangel.t(:comments, scope: :menu), admin_post_comments_path(@source)

        if action == :edit
          section_title = @comment.class.name.split("::").last.humanize.titleize

          add_breadcrumb(
            Archangel.t(:edit_section, section: section_title, scope: :titles),
            edit_admin_post_comment_path(@source, @comment)
          )
        end
      end
    end
  end
end
