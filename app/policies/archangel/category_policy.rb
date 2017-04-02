# frozen_string_literal: true

module Archangel
  # Cateogries authorization policies
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class CategoryPolicy < ApplicationPolicy
    # Check if current use has access to :autocomplete route
    #
    # @return [Boolean] has access to route
    #
    def autocomplete?
      true
    end
  end
end
