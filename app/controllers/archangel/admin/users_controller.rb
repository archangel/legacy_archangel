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
      #       "id": 123,
      #       "name": "John Doe",
      #       "username": "john-doe"
      #     }
      #   ]
      #
      def index
        respond_with @users
      end

      # View a user
      #
      # = Request
      #   GET /admin/users/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the user ID
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "John Doe",
      #     "username": "john-doe"
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
      #     "id": 0,
      #     "name": "",
      #     "username": ""
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
      #       "name": "John Doe",
      #       "username": "john-doe"
      #     }
      #   }
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "John Doe",
      #     "username": "john-doe"
      #   }
      #
      def create
        @user.invite! @user

        respond_with @user, location: -> { admin_users_path }
      end

      # Edit a user
      #
      # = Request
      #   GET /admin/users/:id/edit
      #
      # = Formats
      #   HTML, JSON
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "John Doe",
      #     "slug": "john-doe"
      #   }
      #
      def edit
        respond_with @user
      end

      # Update a user
      #
      # = Request
      #   PATCH /admin/users/:id
      #   PUT   /admin/users/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Request
      #   {
      #     "user": {
      #       "name": "John Doe",
      #       "username": "john-doe"
      #     }
      #   }
      #
      # = Response
      #   {
      #     "id": 123,
      #     "name": "John Doe",
      #     "username": "john-doe"
      #   }
      #
      def update
        @user.update_without_password(user_params)

        respond_with @user, location: -> { admin_users_path }
      end

      # Destroy a user
      #
      # This does not destroy the record. This only marks the user as
      # deleted
      #
      # = Request
      #   DELETE /admin/users/:id
      #
      # = Formats
      #   HTML, JSON
      #
      # = Params
      #   [Integer] id - the user ID
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
          @user = Archangel::User.invite!(user_params) do |u|
            u.skip_invitation = true
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
