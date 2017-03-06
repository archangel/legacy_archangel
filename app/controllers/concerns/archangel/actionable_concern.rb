# frozen_string_literal: true

module Archangel
  # Actionable concern
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module ActionableConcern
    extend ActiveSupport::Concern

    included do
      helper_method :collection_action?,
                    :index_action?,
                    :show_action?,
                    :new_action?,
                    :edit_action?,
                    :member_action?,
                    :save_action?,
                    :restful_action?,
                    :action
    end

    # Controller action as a collection action
    #
    # = Example
    #   "<% collection_action? %>"
    #
    # @return [Boolean] if action is a collection action
    #
    def collection_action?
      collection_actions.include?(action)
    end

    # Controller action as the index action.
    #
    # This is a shortcut for `action?(:index)`
    #
    # = Example
    #   "<% index_action? %>"
    #
    # @return [Boolean] if action is the index action
    #
    def index_action?
      action?(:index)
    end

    # Controller action as the show action.
    #
    # This is a shortcut for `action?(:show)`
    #
    # = Example
    #   "<% show_action? %>"
    #
    # @return [Boolean] if action is the show action
    #
    def show_action?
      action?(:show)
    end

    # Controller action as a new action
    #
    # = Example
    #   "<% new_action? %>"
    #
    # @return [Boolean] if action is a new action
    #
    def new_action?
      [:new, :create].include?(action)
    end

    # Controller action as an edit action
    #
    # = Example
    #   "<% edit_action? %>"
    #
    # @return [Boolean] if action is an edit action
    #
    def edit_action?
      [:edit, :update].include?(action)
    end

    # Controller action as a member action
    #
    # = Example
    #   "<% member_action? %>"
    #
    # @return [Boolean] if action is a member action
    #
    def member_action?
      member_actions.include?(action)
    end

    # Controller action as a save action
    #
    # = Example
    #   "<% save_action? %>"
    #
    # @return [Boolean] if action is a save action
    #
    def save_action?
      save_actions.include?(action)
    end

    # Controller action as a restful action
    #
    # = Example
    #   "<% restful_action? %>"
    #
    # @return [Boolean] if action is restful
    #
    def restful_action?
      restful_actions.include?(action)
    end

    # Controller action as a symbol
    #
    # = Example
    #   "<%= action %>" #=> ":action"
    #
    # @return [Symbol] action symbol
    #
    def action
      action_name.to_sym
    end

    # Controller action
    #
    # = Example
    #   "<% action? %>"
    #
    # @return [Boolean] if action
    #
    def action?(action_method)
      action == action_method.to_sym
    end

    protected

    def collection_actions
      [:index]
    end

    def member_actions
      [:show, :edit, :update, :destroy]
    end

    def save_actions
      [:create, :update, :destroy]
    end

    def restful_actions
      [:index, :show, :new, :create, :edit, :update, :destroy]
    end
  end
end
