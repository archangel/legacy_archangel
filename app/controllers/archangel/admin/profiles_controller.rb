module Archangel
  module Admin
    class ProfilesController < AdminController
      before_action :set_profile
      before_action :set_breadcrumbs
      after_action :skip_authorization

      def show
        respond_with @profile
      end

      def edit
        respond_with @profile
      end

      def update
        empty_password_params! if profile_params[:password].blank?

        successfully_updated = if needs_password?(@profile, profile_params)
                                 @profile.update profile_params
                               else
                                 @profile.update_without_password profile_params
                               end

        reauth_current_user(successfully_updated)

        respond_with @profile, location: -> { admin_profile_path }
      end

      def destroy
        @profile.destroy

        respond_with @profile, location: -> { admin_root_path }
      end

      def retoken
        @profile.regenerate_api_key

        respond_with @profile, location: -> { admin_profile_path }
      end

      protected

      def permitted_attributes
        [
          :avatar, :email, :name, :password, :remove_avatar, :username
        ]
      end

      def set_profile
        @profile = current_user
      end

      def profile_params
        params.require(:profile).permit(permitted_attributes)
      end

      def empty_password_params!
        profile_params.delete(:password)
        profile_params.delete(:password_confirmation)
      end

      def needs_password?(_profile, params)
        params[:password].present?
      end

      protected

      def reauth_current_user(successful)
        sign_in @profile, bypass: true if successful && @profile == current_user
      end

      def set_breadcrumbs
        add_breadcrumb Archangel.t(:dashboard, scope: :menu), admin_root_path
        add_breadcrumb Archangel.t(:profile, scope: :menu), admin_profile_path

        action = action_name.to_sym
        section_title = @profile.name if [:edit].include?(action)

        if action == :edit
          add_breadcrumb(
            Archangel.t(:edit_section, section: section_title, scope: :titles),
            edit_admin_profile_path
          )
        end
      end
    end
  end
end
