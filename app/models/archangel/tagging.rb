module Archangel
  # Tagging model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Tagging < ApplicationRecord
    # Associations
    belongs_to :tag
    belongs_to :taggable, polymorphic: true
  end
end
