# frozen_string_literal: true

module Archangel
  # Tag model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Tag < ApplicationRecord
    acts_as_paranoid

    before_validation :parameterize_slug

    after_destroy :column_reset

    validates :name, presence: true
    validates :slug, presence: true, uniqueness: true

    has_many :taggings
    has_many :pages, through: :taggings,
                     source: :taggable,
                     source_type: "Archangel::Page"

    default_scope { order(name: :asc) }

    # Override column used for constructing the URL to this object
    #
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
