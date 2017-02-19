# frozen_string_literal: true

module Archangel
  # Categorization model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Categorization < ApplicationRecord
    # Associations
    belongs_to :category
    belongs_to :categorizable, polymorphic: true

    has_many :categorizations, as: :categorizable
  end
end
