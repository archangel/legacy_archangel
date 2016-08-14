module Archangel
  class CategoryPolicy < ApplicationPolicy
    def autocomplete?
      true
    end
  end
end
