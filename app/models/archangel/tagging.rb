module Archangel
  class Tagging < ApplicationRecord
    # Associations
    belongs_to :tag
    belongs_to :taggable, polymorphic: true
  end
end
