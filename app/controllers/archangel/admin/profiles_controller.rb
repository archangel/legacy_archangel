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

      # View profile
      #
      # = Request
      #   GET /admin/profile
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "John Doe",
      #     "username": "john-doe",
      #     "role": "admin",
      #     "avatar": {
      #       "url": "/path/to/avatar.jpg",
      #       "medium": {
      #         "url": "/path/to/medium_avatar.jpg"
      #       },
      #       "thumb": {
      #         "url": "/path/to/thumb_avatar.jpg"
      #       },
      #      "mini": {
      #         "url": "/path/to/mini_avatar.jpg"
      #       },
      #       "micro": {
      #         "url": "/path/to/micro_avatar.jpg"
      #       }
      #     },
      #     "email": "user@example.com",
      #     "invitation_token": "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      #     "invitation_created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "invitation_sent_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "invitation_accepted_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "invitation_limit": null,
      #     "invited_by_type": "Archangel::User",
      #     "invited_by_id": 123,
      #     "invitations_count": 0,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @profile
      end

      # Edit profile
      #
      # = Request
      #   GET /admin/profile/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "John Doe",
      #     "username": "john-doe",
      #     "role": "admin",
      #     "avatar": {
      #       "url": "/path/to/avatar.jpg",
      #       "medium": {
      #         "url": "/path/to/medium_avatar.jpg"
      #       },
      #       "thumb": {
      #         "url": "/path/to/thumb_avatar.jpg"
      #       },
      #      "mini": {
      #         "url": "/path/to/mini_avatar.jpg"
      #       },
      #       "micro": {
      #         "url": "/path/to/micro_avatar.jpg"
      #       }
      #     },
      #     "email": "user@example.com",
      #     "invitation_token": "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      #     "invitation_created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "invitation_sent_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "invitation_accepted_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "invitation_limit": null,
      #     "invited_by_type": "Archangel::User",
      #     "invited_by_id": 123,
      #     "invitations_count": 0,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @profile
      end

      # Update profile
      #
      # = Request
      #   PATCH /admin/profile
      #   PUT   /admin/profile
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "profile": {
      #       "name": "Updated Name",
      #       "username": "updated-name",
      #       "avatar": "local/path/to/avatar.jpg",
      #       "email": "user@example.com"
      #     }
      #   }
      #
      def update
        empty_password_params if profile_params[:password].blank?

        successfully_updated = if needs_password?(@profile, profile_params)
                                 @profile.update profile_params
                               else
                                 @profile.update_without_password profile_params
                               end

        reauth_current_user if successfully_updated

        respond_with @profile, location: -> { admin_profile_path }
      end

      # Destroy profile
      #
      # Current user is logged out. This does not destroy the record. This only
      # marks the tag as deleted
      #
      # = Request
      #   DELETE /admin/profile
      #
      # = Formats
      #   HTML, JSON
      #
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

      def empty_password_params
        profile_params.delete(:password)
        profile_params.delete(:password_confirmation)
      end

      def needs_password?(_profile, params)
        params[:password].present?
      end

      def reauth_current_user
        bypass_sign_in(@profile)
      end
    end
  end
end
