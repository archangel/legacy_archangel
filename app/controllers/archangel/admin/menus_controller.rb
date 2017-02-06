module Archangel
  module Admin
    # Admin menus controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class MenusController < AdminController
      before_action :set_menus, only: [:index]
      before_action :set_new_menu, only: [:create, :new]
      before_action :set_menu, only: [:destroy, :edit, :show, :update]

      helper Archangel::Admin::MenusHelper

      def index
        respond_with @menus
      end

      def show
        respond_with @menu
      end

      def new
        respond_with @menu
      end

      def create
        @menu.save

        respond_with @menu, location: -> { admin_menus_path }
      end

      def edit
        respond_with @menu
      end

      def update
        @menu.update(menu_params)

        respond_with @menu, location: -> { admin_menus_path }
      end

      def destroy
        @menu.destroy

        respond_with @menu, location: -> { admin_menus_path }
      end

      protected

      def permitted_attributes
        [
          :active_leaf_class, :attr_class, :attr_id, :name, :selected_class,
          :slug,

          menu_items_attributes: [
            :id, :_destroy,
            :menu_id, :parent_id, :label, :attr_id, :attr_class, :target,
            :highlights_on, :url, :menuable_id, :menuable_type, :method,
            :position, :deleted_at
          ]
        ]
      end

      def menu_params
        params.require(:menu).permit(permitted_attributes)
      end

      def set_menus
        @menus = Archangel::Menu.all

        authorize @menus
      end

      def set_new_menu
        new_params = action_name.to_sym == :create ? menu_params : nil

        @menu = Archangel::Menu.new(new_params)

        authorize @menu
      end

      def set_menu
        @menu = Archangel::Menu.find_by!(slug: params[:id])

        authorize @menu
      end
    end
  end
end
