# frozen_string_literal: true

module Archangel
  # Tags authorization policies
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class TagPolicy < ApplicationPolicy
    def autocomplete?
      true
    end
  end
end
