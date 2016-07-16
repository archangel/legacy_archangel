module Archangel
  module ActionableConcern
    extend ActiveSupport::Concern

    included do
      helper_method :collection_action?,
                    :index_action?,
                    :show_action?,
                    :new_action?,
                    :edit_action?,
                    :member_action?,
                    :update_action?,
                    :restful_action?,
                    :action
    end

    def collection_action?
      collection_actions.include?(action)
    end

    def index_action?
      action == :index
    end

    def show_action?
      action == :show
    end

    def new_action?
      action == :new
    end

    def edit_action?
      action == :edit
    end

    def member_action?
      !collection_actions.include?(action)
    end

    def update_action?
      update_actions.include?(action)
    end

    def restful_action?
      !restful_actions.include?(action)
    end

    def action
      action_name.to_sym
    end

    protected

    def collection_actions
      [:index]
    end

    def resource_actions
      [:show, :edit, :update, :destroy]
    end

    def new_actions
      [:new, :create]
    end

    def update_actions
      [:new, :edit]
    end

    def commit_actions
      [:create, :update, :destroy]
    end

    def restful_actions
      [:index, :show, :new, :create, :edit, :update, :destroy]
    end
  end
end
