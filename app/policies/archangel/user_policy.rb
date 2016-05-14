module Archangel
  class UserPolicy < ApplicationPolicy
    def retoken?
      true
    end
  end
end
