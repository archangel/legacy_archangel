# frozen_string_literal: true

module Archangel
  module Admin
    # Admin assets controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class AssetsController < AdminController
      before_action :set_assets, only: %i[index]
      before_action :set_new_asset, only: %i[create new]
      before_action :set_asset, only: %i[destroy edit show update]

      helper Archangel::Admin::AssetsHelper

      respond_to :json

      # List of all pages
      #
      # = Request
      #   GET /admin/pages
      #   GET /admin/pages/page/:page
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] page - the page number
      #
      # = Response
      #   [
      #     {
      #       "id": 123,
      #       "title": "Asset title",
      #       "description": "Asset description",
      #       "file": {
      #         "url": "/path/to/uploaded/file.jpg",
      #         "thumb": {
      #           "url": "/path/to/uploaded/thumb_file.jpg"
      #         },
      #         "mini": {
      #           "url": "/path/to/uploaded/mini_file.jpg"
      #         }
      #       },
      #       "uploader_id": 123,
      #       "assetable_id": null,
      #       "assetable_type": null,
      #       "file_size": 12345,
      #       "content_type": "image/jpeg",
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @assets
      end

      # View an asset
      #
      # = Request
      #   GET /admin/pages/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the page ID
      #
      # = Response
      #   {
      #     "id": 123,
      #     "title": "Asset title",
      #     "description": "Asset description",
      #     "file": {
      #       "url": "/path/to/uploaded/file.jpg",
      #       "thumb": {
      #         "url": "/path/to/uploaded/thumb_file.jpg"
      #       },
      #       "mini": {
      #         "url": "/path/to/uploaded/mini_file.jpg"
      #       }
      #     },
      #     "uploader_id": 123,
      #     "assetable_id": null,
      #     "assetable_type": null,
      #     "file_size": 12345,
      #     "content_type": "image/jpeg",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @asset
      end

      # New asset
      #
      # = Request
      #   GET /admin/pages/new
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": null,
      #     "title": null,
      #     "description": null,
      #     "file": {
      #       "url": "/path/to/uploaded/default_file.jpg",
      #       "thumb": {
      #         "url": "/path/to/uploaded/thumb_default_file.jpg"
      #       },
      #       "mini": {
      #         "url": "/path/to/uploaded/mini_default_file.jpg"
      #       }
      #     },
      #     "uploader_id": null,
      #     "assetable_id": null,
      #     "assetable_type": null,
      #     "file_size": null,
      #     "content_type": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @asset
      end

      # Create a new asset
      #
      # = Request
      #   POST /admin/assets
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "asset": {
      #       "title": "Asset title",
      #       "description": "Asset description",
      #       "file": "local/path/to/file.jpg"
      #     }
      #   }
      #
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

      # Edit an asset
      #
      # = Request
      #   GET /admin/assets/:id/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the asset ID
      #
      # = Response
      #   {
      #     "id": 123,
      #     "title": "Asset title",
      #     "description": "Asset description",
      #     "file": {
      #       "url": "/path/to/uploaded/file.jpg",
      #       "thumb": {
      #         "url": "/path/to/uploaded/thumb_file.jpg"
      #       },
      #       "mini": {
      #         "url": "/path/to/uploaded/mini_file.jpg"
      #       }
      #     },
      #     "uploader_id": 123,
      #     "assetable_id": null,
      #     "assetable_type": null,
      #     "file_size": 12345,
      #     "content_type": "image/jpeg",
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @asset
      end

      # Update an asset
      #
      # = Request
      #   PATCH /admin/assets/:id
      #   PUT   /admin/assets/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the asset ID
      #
      # = Request
      #   {
      #     "asset": {
      #       "title": "Updated asset title",
      #       "description": "Updated asset description",
      #       "file": "local/path/to/file.jpg"
      #     }
      #   }
      #
      def update
        @asset.update(asset_params)

        respond_with @asset, location: -> { admin_assets_path }
      end

      # Destroy an asset
      #
      # = Request
      #   DELETE /admin/assets/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the asset ID
      #
      def destroy
        @asset.destroy

        respond_with @asset, location: -> { admin_assets_path }
      end

      protected

      def permitted_attributes
        %i[description file title]
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
        @assets = Archangel::Asset.page(page_num).per(per_page)

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
