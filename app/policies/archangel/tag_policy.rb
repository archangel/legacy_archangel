# frozen_string_literal: true

module Archangel
  # Tags authorization policies
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class TagPolicy < ApplicationPolicy
    # Check if current user has access to :autocomplete route
    #
    # @return [Boolean] has access to route
    #
    def autocomplete?
      true
    end
  end
end
