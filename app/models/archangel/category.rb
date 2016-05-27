module Archangel
  class Category < ActiveRecord::Base
    acts_as_paranoid

    # Callbacks
    before_validation :parameterize_slug
    after_destroy :column_reset

    # Validation
    validates :name, presence: true
    validates :slug, presence: true, length: { maximum: 24 }

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
