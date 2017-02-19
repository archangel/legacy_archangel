# frozen_string_literal: true

module Archangel
  module Admin
    # Admin profile controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class ProfilesController < AdminController
      include Archangel::SkipAuthorizableConcern

      before_action :set_profile

      helper Archangel::Admin::ProfilesHelper

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

      def reauth_current_user(successful)
        bypass_sign_in(@profile) if successful
      end
    end
  end
end
