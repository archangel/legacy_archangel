module Archangel
  module Admin
    class UsersController < AdminController
      before_action :set_users, only: [:index]
      before_action :set_new_user, only: [:create, :new]
      before_action :set_user, only: [:destroy, :edit, :show, :update]

      helper Archangel::Admin::UsersHelper

      def index
        respond_with @users
      end

      def show
        respond_with @user
      end

      def new
        respond_with @user
      end

      def create
        @user.invite! @user

        respond_with @user, location: -> { admin_users_path }
      end

      def edit
        respond_with @user
      end

      def update
        @user.update_without_password(user_params)

        respond_with @user, location: -> { admin_users_path }
      end

      def destroy
        @user.destroy

        respond_with @user, location: -> { admin_users_path }
      end

      protected

      def permitted_attributes
        [
          :email, :name, :remove_avatar, :username
        ]
      end

      def set_users
        @users = Archangel::User.where.not(id: current_user.id)
                                .page(params[:page])
                                .per(per_page)

        authorize @users
      end

      def set_new_user
        if action_name.to_sym == :create
          @user = Archangel::User.invite!(user_params) do |u|
            u.skip_invitation = true
          end
        else
          @user = Archangel::User.new
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
