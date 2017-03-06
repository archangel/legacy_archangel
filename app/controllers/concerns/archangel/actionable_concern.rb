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

    def collection_action?
      collection_actions.include?(action)
    end

    def index_action?
      action?(:index)
    end

    def show_action?
      action?(:show)
    end

    def new_action?
      [:new, :create].include?(action)
    end

    def edit_action?
      [:edit, :update].include?(action)
    end

    def member_action?
      member_actions.include?(action)
    end

    def save_action?
      save_actions.include?(action)
    end

    def restful_action?
      restful_actions.include?(action)
    end

    def action
      action_name.to_sym
    end

    protected

    def action?(action_method)
      action == action_method.to_sym
    end

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
