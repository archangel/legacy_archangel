module Archangel
  class Category < ApplicationRecord
    acts_as_paranoid

    # Callbacks
    before_validation :parameterize_slug
    after_destroy :column_reset

    # Validation
    validates :name, presence: true
    validates :slug, presence: true, uniqueness: true

    # Associations
    has_many :categorizations
    has_many :pages, through: :categorizations,
                     source: :categorizable,
                     source_type: "Archangel::Page"

    # Default scope
    default_scope { order(name: :asc) }

    def to_param
      slug
    end

    protected

    def parameterize_slug
      self.slug = slug.to_s.downcase.parameterize
    end

    def column_reset
      self.slug = "#{Time.current.to_i}_#{slug}"
      self.save
    end
  end
end
