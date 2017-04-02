# frozen_string_literal: true

module Archangel
  # Tagging model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Tagging < ApplicationRecord
    belongs_to :tag
    belongs_to :taggable, polymorphic: true
  end
end
