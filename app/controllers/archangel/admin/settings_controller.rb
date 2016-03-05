module Archangel
  module Admin
    class SettingsController < AdminController
      before_action :set_settings

      def show
        respond_with @settings
      end

      def edit
        respond_with @settings
      end

      def update
        @settings.update(settings_params)

        respond_with @settings, location: -> { admin_settings_path }
      end

      protected

      def permitted_attributes
        [
          :title, :per_page, :logo, :remove_logo
        ]
      end

      def set_settings
        @settings = Archangel::Setting.settings

        authorize @settings
      end

      def settings_params
        params.require(:settings).permit(permitted_attributes)
      end
    end
  end
end
