module Archangel
  module Admin
    class UsersController < AdminController
      before_action :set_user, only: [:retoken, :show, :new, :edit, :update, :destroy]
      before_action :set_breadcrumbs

      helper Archangel::Admin::UsersHelper

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

      def retoken
        @user.regenerate_api_key

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

      def set_breadcrumbs
        add_breadcrumb Archangel.t(:dashboard, scope: :menu), admin_root_path
        add_breadcrumb Archangel.t(:users, scope: :menu), admin_users_path

        action = action_name.to_sym
        section_name = @user.class.name.split("::").last.humanize.titleize
        section_title = @user.name if [:show, :edit].include?(action)

        if action == :show
          add_breadcrumb(
            Archangel.t(:show_section, section: section_title, scope: :titles),
            admin_user_path(@user)
          )
        elsif action == :new
          add_breadcrumb(
            Archangel.t(:new_section, section: section_name, scope: :titles),
            new_admin_user_path
          )
        elsif action == :edit
          add_breadcrumb(
            Archangel.t(:edit_section, section: section_title, scope: :titles),
            edit_admin_user_path(@user)
          )
        end
      end
    end
  end
end
