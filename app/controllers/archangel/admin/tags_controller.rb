module Archangel
  module Admin
    class TagsController < AdminController
      before_action :set_tags, only: [:index]
      before_action :set_new_tag, only: [:create, :new]
      before_action :set_tag, only: [:destroy, :edit, :show, :update]
      before_action :set_autocomplete_tags, only: [:autocomplete]

      helper Archangel::Admin::TagsHelper

      def index
        respond_with @tags
      end

      def show
        respond_with @tag
      end

      def new
        respond_with @tag
      end

      def create
        @tag.save

        respond_with @tag, location: -> { admin_tags_path }
      end

      def edit
        respond_with @tag
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

      def set_tags
        @tags = Archangel::Tag.page(params[:page]).per(per_page)

        authorize @tags
      end

      def set_new_tag
        new_params = action_name.to_sym == :create ? tag_params : nil

        @tag = Archangel::Tag.new(new_params)

        authorize @tag
      end

      def set_tag
        @tag = Archangel::Tag.find_by!(slug: params[:id])

        authorize @tag
      end

      def set_autocomplete_tags
        query = params.fetch(:q, "").to_s.strip

        @q = Archangel::Tag.ransack(description_or_name_cont: query)

        @tags = @q.result(distinct: true).order(:name).limit(25)

        authorize @tags
      end
    end
  end
end
