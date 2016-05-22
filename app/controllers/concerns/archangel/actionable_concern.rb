module Archangel
  module ActionableConcern
    extend ActiveSupport::Concern

    included do
      helper_method :collection_action?,
                    :edit_action?,
                    :member_action?,
                    :new_action?,
                    :show_action?,
                    :update_action?
    end

    def collection_action?
      collection_actions.include?(action)
    end

    def edit_action?
      action == :edit
    end

    def member_action?
      !collection_actions.include?(action)
    end

    def new_action?
      action == :new
    end

    def show_action?
      action == :show
    end

    def update_action?
      update_actions.include?(action)
    end

    protected

    def action
      action_name.to_sym
    end

    def collection_actions
      [:index]
    end

    def update_actions
      [:new, :edit]
    end
  end
end
