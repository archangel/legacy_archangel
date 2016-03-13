module Archangel
  class Page < ActiveRecord::Base
    extend ActsAsTree::TreeView
    extend FriendlyId

    friendly_id :slug_candidates, use: :scoped, scope: :parent_id

    acts_as_list top_of_list: 0, scope: :parent
    acts_as_tree order: :position

    # Callbacks
    before_validation :parameterize_slug
    before_save :build_path_before_save

    # Validation
    validates :author_id, presence: true
    validates :content, presence: true, allow_blank: true
    validates :path, presence: true, allow_blank: true, uniqueness: true
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true, length: { maximum: 24 }
    validates :title, presence: true

    validate :unique_slug_per_level

    # Associations
    belongs_to :author, class_name: Archangel::User

    def slug_candidates
      [
        :slug,
        [:slug, :title],
        [:slug, :title, :id]
      ]
    end

    def to_param
      id
    end

    protected

    def unique_slug_per_level
      unless unique_slug_per_level?
        errors.add(:slug, "can't have the same slug for this level")
      end
    end

    def parameterize_slug
      self.slug = slug.to_s.downcase.parameterize
    end

    def build_path_before_save
      parent_path = parent.nil? ? nil : parent.path

      self.path = [parent_path, slug].compact.join("/")
    end

    private

    def unique_slug_per_level?
      Page.where(parent_id: parent_id, slug: slug).where.not(id: id).empty?
    end
  end
end
