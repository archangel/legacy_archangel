module Archangel
  module Admin
    class TagsController < AdminController
      before_action :set_tag, only: [:show, :new, :edit, :update, :destroy]

      helper Archangel::Admin::TagsHelper

      def index
        @tags = Archangel::Tag.page(params[:page]).per(per_page)

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

      def autocomplete
        query = params.fetch(:q, "").to_s.strip

        @q = Archangel::Tag.ransack(description_or_name_cont: query)

        @tags = @q.result(distinct: true).order(:name).limit(25)

        authorize @tags

        respond_with @tags
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
        @tag = if action_name.to_sym == :new
                 Archangel::Tag.new
               else
                 Archangel::Tag.find_by!(slug: params[:id])
               end

        authorize @tag
      end
    end
  end
end
