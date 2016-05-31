module Archangel
  class Tagging < ActiveRecord::Base
    # Associations
    belongs_to :tag
    belongs_to :taggable, polymorphic: true
  end
end
