module Archangel
  module Admin
    class UsersController < AdminController
      before_action :set_user, only: [:show, :new, :edit, :update, :destroy]

      def index
        @users = Archangel::User.where.not(id: current_user.id)
                                .page(params[:page])
                                .per(per_page)

        authorize @users

        respond_with @users
      end

      def show
        respond_with @user
      end

      def new
        respond_with @user
      end

      def edit
        respond_with @user
      end

      def create
        @user = Archangel::User.invite!(user_params)

        authorize @user

        respond_with @user, location: -> { admin_users_path }
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
          :email, :name, :remove_avatar, :role, :username
        ]
      end

      def set_user
        if action_name.to_sym == :new
          @user = Archangel::User.new
        else
          @user = Archangel::User.where.not(id: current_user.id)
                                 .find_by(username: params[:id])
        end

        authorize @user
      end

      def user_params
        params.require(:user).permit(permitted_attributes)
      end
    end
  end
end
