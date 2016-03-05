module Archangel
  class Page < ActiveRecord::Base
    extend FriendlyId

    friendly_id :path, use: :slugged

    # Callbacks
    before_validation :parameterize_path

    # Validation
    validates :content, presence: true, allow_blank: true
    validates :path, presence: true, allow_blank: true, uniqueness: true
    validates :title, presence: true

    # Default scope
    default_scope { order(title: :asc, slug: :asc) }

    def should_generate_new_friendly_id?
      path_changed?
    end

    protected

    def parameterize_path
      new_path = path.to_s
                     .split("/")
                     .map(&:parameterize)
                     .reject(&:blank?)
                     .join("/")

      self.path = new_path
    end
  end
end
