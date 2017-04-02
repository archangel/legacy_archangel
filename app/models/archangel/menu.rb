# frozen_string_literal: true

module Archangel
  # Menu model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Menu < ApplicationRecord
    acts_as_paranoid

    before_validation :parameterize_slug

    after_destroy :column_reset

    validates :name, presence: true
    validates :slug, presence: true, uniqueness: true

    has_many :menu_items, -> { where(parent_id: nil) }, dependent: :destroy

    accepts_nested_attributes_for :menu_items, reject_if: :all_blank,
                                               allow_destroy: true

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
