module Archangel
  class Post < ActiveRecord::Base
    acts_as_paranoid

    # Callbacks
    before_validation :parameterize_slug
    after_destroy :column_reset

    # Validation
    validates :author_id, presence: true
    validates :content, presence: true, allow_blank: true
    validates :excerpt, presence: true, allow_blank: true
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true, length: { maximum: 24 }
    validates :title, presence: true

    # Associations
    belongs_to :author, class_name: Archangel::User

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
