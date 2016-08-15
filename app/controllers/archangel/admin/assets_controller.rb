module Archangel
  module Admin
    class AssetsController < AdminController
      respond_to :json

      def create
        @asset = Archangel::Asset.new(asset_params)

        authorize @asset

        @asset.save

        render json: {
          image: {
            url: @asset.file.url
          }
        }, content_type: "text/html"
      end

      protected

      def permitted_attributes
        [
          :file
        ]
      end

      def asset_params
        params.permit(permitted_attributes)
              .merge(uploader_id: current_user.id)
      end
    end
  end
end