module Archangel
  module Admin
    class AssetsController < AdminController
      before_action :set_assets, only: [:index]
      before_action :set_new_asset, only: [:create, :new]
      before_action :set_asset, only: [:destroy, :edit, :show, :update]

      helper Archangel::Admin::AssetsHelper

      respond_to :json

      def index
        respond_with @assets
      end

      def show
        respond_with @asset
      end

      def new
        respond_with @asset
      end

      def create
        @asset.save

        respond_to do |format|
          format.html do
            respond_with @asset, location: -> { admin_assets_path }
          end
          format.json do
            render json: { success: true, file: @asset.file.url }
          end
        end
      end

      def edit
        respond_with @asset
      end

      def update
        @asset.update(asset_params)

        respond_with @asset, location: -> { admin_assets_path }
      end

      def destroy
        @asset.destroy

        respond_with @asset, location: -> { admin_assets_path }
      end

      protected

      def permitted_attributes
        [
          :description, :file, :title
        ]
      end

      def asset_xhr_params
        params.permit(permitted_attributes)
              .merge(uploader_id: current_user.id)
      end

      def asset_params
        params.require(:asset)
              .permit(permitted_attributes)
              .merge(uploader_id: current_user.id)
      end

      def set_assets
        @assets = Archangel::Asset.page(params[:page]).per(per_page)

        authorize @assets
      end

      def set_new_asset
        if action_name.to_sym == :create
          params = request.xhr? ? asset_xhr_params : asset_params

          @asset = Archangel::Asset.new(params)
        else
          @asset = Archangel::Asset.new
        end

        authorize @asset
      end

      def set_asset
        @asset = Archangel::Asset.find_by!(id: params[:id])

        authorize @asset
      end
    end
  end
end
