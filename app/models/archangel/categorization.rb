module Archangel
  class Categorization < ApplicationRecord
    # Associations
    belongs_to :category
    belongs_to :categorizable, polymorphic: true

    has_many :categorizations, as: :categorizable
  end
end
