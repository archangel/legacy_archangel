# frozen_string_literal: true

module Archangel
  module Admin
    # Admin users controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class UsersController < AdminController
      before_action :set_users, only: [:index]
      before_action :set_new_user, only: [:create, :new]
      before_action :set_user, only: [:destroy, :edit, :show, :update]

      helper Archangel::Admin::UsersHelper

      # List of all users
      #
      # Current logged in user is not returned in this list. You are not able to
      # view or modify yourself in the same way you are able to view and modify
      # others
      #
      # = Request
      #   GET /admin/users
      #   GET /admin/users/page/:page
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
      #       "id": 2,
      #       "name": "John Doe",
      #       "username": "john-doe",
      #       "role": "admin",
      #       "avatar": {
      #         "url": "/path/to/avatar.jpg",
      #         "medium": {
      #           "url": "/path/to/medium_avatar.jpg"
      #         },
      #         "thumb": {
      #           "url": "/path/to/thumb_avatar.jpg"
      #         },
      #        "mini": {
      #           "url": "/path/to/mini_avatar.jpg"
      #         },
      #         "micro": {
      #           "url": "/path/to/micro_avatar.jpg"
      #         }
      #       },
      #       "email": "user@example.com",
      #       "invitation_token": "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      #       "invitation_created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "invitation_sent_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "invitation_accepted_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "invitation_limit": null,
      #       "invited_by_type": "Archangel::User",
      #       "invited_by_id": 123,
      #       "invitations_count": 0,
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @users
      end

      # View a user
      #
      # = Request
      #   GET /admin/user/:username
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] username - the user username
      #
      # = Response
      #   {
      #     "id": 2,
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
        respond_with @user
      end

      # New user
      #
      # = Request
      #   GET /admin/users/new
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": null,
      #     "name": "",
      #     "username": "",
      #     "role": "editor",
      #     "avatar": {
      #       "url": "/path/to/default_avatar.jpg",
      #       "medium": {
      #         "url": "/path/to/medium_default_avatar.jpg",
      #       },
      #       "thumb": {
      #         "url": "/path/to/thumb_default_avatar.jpg",
      #       },
      #       "mini": {
      #         "url": "/path/to/mini_default_avatar.jpg",
      #       },
      #       "micro": {
      #         "url": "/path/to/micro_default_avatar.jpg",
      #       }
      #     },
      #     "email": "",
      #     "invitation_token": null,
      #     "invitation_created_at": null,
      #     "invitation_sent_at": null,
      #     "invitation_accepted_at": null,
      #     "invitation_limit": null,
      #     "invited_by_type": null,
      #     "invited_by_id": null,
      #     "invitations_count": 0,
      #     "deleted_at": null,
      #     "created_at": null,
      #     "updated_at": null
      #   }
      #
      def new
        respond_with @user
      end

      # Create a new user
      #
      # = Request
      #   POST /admin/users
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "user": {
      #       "name": "New User",
      #       "username": "new-user",
      #       "role": "editor",
      #       "avatar": "local/path/to/avatar.jpg",
      #       "email": "user@example.com"
      #     }
      #   }
      #
      def create
        @user.invite! @user

        respond_with @user, location: -> { admin_users_path }
      end

      # Edit a user
      #
      # = Request
      #   GET /admin/users/:username/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] username - the user username
      #
      # = Response
      #   {
      #     "id": 2,
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
        respond_with @user
      end

      # Update a user
      #
      # = Request
      #   PATCH /admin/users/:username
      #   PUT   /admin/users/:username
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] username - the user username
      #
      # = Request
      #   {
      #     "user": {
      #       "name": "Updated Name",
      #       "username": "updated-name",
      #       "role": "editor",
      #       "avatar": "local/path/to/avatar.jpg",
      #       "email": "user@example.com"
      #     }
      #   }
      #
      def update
        @user.update_without_password(user_params)

        respond_with @user, location: -> { admin_users_path }
      end

      # Destroy a user
      #
      # This does not destroy the record. This only marks the user as deleted.
      # Email address and username are prefixed with current timestamp so they
      # can be used again
      #
      # = Request
      #   DELETE /admin/users/:username
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] username - the user username
      #
      def destroy
        @user.destroy

        respond_with @user, location: -> { admin_users_path }
      end

      protected

      def permitted_attributes
        [
          :email, :name, :remove_avatar, :role, :username
        ]
      end

      def set_users
        @users = Archangel::User.where.not(id: current_user.id)
                                .page(params[:page])
                                .per(per_page)

        authorize @users
      end

      def set_new_user
        @user = Archangel::User.new

        if action_name.to_sym == :create
          @user = Archangel::User.invite!(user_params) do |user|
            user.skip_invitation = true
          end
        end

        authorize @user
      end

      def set_user
        @user = Archangel::User.where.not(id: current_user.id)
                               .find_by!(username: params[:id])

        authorize @user
      end

      def user_params
        params.require(:user).permit(permitted_attributes)
      end
    end
  end
end




      # # Create a new page
      # #
      # # = Request
      # #   POST /admin/pages
      # #
      # # = Formats
      # #   HTML, JSON
      # #
      # # = Request
      # #   {
      # #     "page": {
      # #       "title": "Updated Page Title",
      # #       "author_id": 123,
      # #       "parent_id": null,
      # #       "slug": "updated-slug",
      # #       "homepage": false,
      # #       "content": "</p>Updated content of the page</p>",
      # #       "meta_keywords": "updated, keywords, for, the, page",
      # #       "meta_description": "Updated description of the page",
      # #       "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      # #     }
      # #   }
      # #
      # def create
      #   @page.save
      #
      #   respond_with @page, location: -> { admin_pages_path }
      # end
      #
      # # Edit a page
      # #
      # # = Request
      # #   GET /admin/pages/:id/edit
      # #
      # # = Formats
      # #   HTML, JSON
      # #
      # # = Response
      # #   {
      # #     "id": 123,
      # #     "title": "Page Title",
      # #     "author_id": 123,
      # #     "parent_id": null,
      # #     "path": "foo/bar",
      # #     "slug": "bar",
      # #     "homepage": false,
      # #     "content": "</p>Content of the page</p>",
      # #     "meta_keywords": "keywords, for, the, page",
      # #     "meta_description": "Description of the page",
      # #     "deleted_at": null,
      # #     "published_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      # #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      # #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      # #   }
      # #
      # def edit
      #   respond_with @page
      # end
      #
