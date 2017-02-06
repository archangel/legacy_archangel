module Archangel
  # Menu model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Menu < ApplicationRecord
    acts_as_paranoid

    # Callbacks
    before_validation :parameterize_slug

    after_destroy :column_reset

    # Validation
    validates :active_leaf_class, presence: true
    validates :name, presence: true
    validates :selected_class, presence: true
    validates :slug, presence: true, uniqueness: true

    # Associations
    has_many :menu_items

    # Nested attributes
    accepts_nested_attributes_for :menu_items, reject_if: :all_blank,
                                               allow_destroy: true

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

      save
    end
  end
end
