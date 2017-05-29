# frozen_string_literal: true

module Archangel
  # Application authorization policies
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class ApplicationPolicy
    # Requested object
    #
    attr_reader :record

    # Current user
    #
    attr_reader :user

    def initialize(user, record)
      @user = user
      @record = record
    end

    # Check if current user has access to :index route
    #
    # @return [Boolean] has access to route
    #
    def index?
      true
    end

    # Check if current user has access to :show route
    #
    # @return [Boolean] has access to route
    #
    def show?
      scope.where(id: record.id).exists?
    end

    # Check if current user has access to :create route
    #
    # @return [Boolean] has access to route
    #
    def create?
      true
    end

    # Check if current user has access to :new route
    #
    # @return [Boolean] has access to route
    #
    def new?
      create?
    end

    # Check if current user has access to :update route
    #
    # @return [Boolean] has access to route
    #
    def update?
      true
    end

    # Check if current user has access to :edit route
    #
    # @return [Boolean] has access to route
    #
    def edit?
      update?
    end

    # Check if current user has access to :destroy route
    #
    # @return [Boolean] has access to route
    #
    def destroy?
      true
    end

    # Scope
    #
    def scope
      Pundit.policy_scope!(user, record.class)
    end

    # Scope
    #
    class Scope
      # Object scope
      #
      attr_reader :scope

      # Current user
      #
      attr_reader :user

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      # Resolve
      #
      def resolve
        scope
      end
    end
  end
end
