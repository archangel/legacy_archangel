module Archangel
  module Admin
    class TagsController < AdminController
      before_action :set_tag, only: [:show, :new, :edit, :update, :destroy]
      before_action :set_breadcrumbs

      helper Archangel::Admin::TagsHelper

      def index
        @tags = Archangel::Tag.all

        authorize @tags

        respond_with @tags
      end

      def show
        respond_with @tag
      end

      def new
        respond_with @tag
      end

      def edit
        respond_with @tag
      end

      def create
        @tag = Archangel::Tag.new(tag_params)

        authorize @tag

        @tag.save

        respond_with @tag, location: -> { admin_tags_path }
      end

      def update
        @tag.update(tag_params)

        respond_with @tag, location: -> { admin_tags_path }
      end

      def destroy
        @tag.destroy

        respond_with @tag, location: -> { admin_tags_path }
      end

      protected

      def permitted_attributes
        [
          :description, :name, :slug
        ]
      end

      def tag_params
        params.require(:tag).permit(permitted_attributes)
      end

      def set_tag
        if action_name.to_sym == :new
          @tag = Archangel::Tag.new
        else
          @tag = Archangel::Tag.find_by(slug: params[:id])
        end

        authorize @tag
      end

      def set_breadcrumbs
        add_breadcrumb Archangel.t(:dashboard, scope: :menu), admin_root_path
        add_breadcrumb Archangel.t(:tags, scope: :menu), admin_tags_path

        action = action_name.to_sym
        section_name = @tag.class.name.split("::").last.humanize.titleize
        section_title = @tag.name if [:show, :edit].include?(action)

        if action == :show
          add_breadcrumb(
            Archangel.t(:show_section, section: section_title, scope: :titles),
            admin_tag_path(@tag)
          )
        elsif action == :new
          add_breadcrumb(
            Archangel.t(:new_section, section: section_name, scope: :titles),
            new_admin_tag_path
          )
        elsif action == :edit
          add_breadcrumb(
            Archangel.t(:edit_section, section: section_title, scope: :titles),
            edit_admin_tag_path(@tag)
          )
        end
      end
    end
  end
end
