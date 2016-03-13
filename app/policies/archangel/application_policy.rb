module Archangel
  class ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      true
    end

    def show?
      scope.where(id: record.id).exists?
    end

    def create?
      true
    end

    def new?
      create?
    end

    def update?
      true
    end

    def edit?
      update?
    end

    def destroy?
      true
    end

    def scope
      Pundit.policy_scope!(user, record.class)
    end

    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        scope
      end
    end

    protected

    def management_role?
      user.manager? || user.admin?
    end

    def administive_role?
      user.admin?
    end
  end
end
