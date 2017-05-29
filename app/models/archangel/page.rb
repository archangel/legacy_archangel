# frozen_string_literal: true

module Archangel
  # Page model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Page < ApplicationRecord
    extend ActsAsTree::TreeView

    acts_as_tree order: :title
    acts_as_paranoid

    before_validation :parameterize_slug

    before_save :stringify_meta_keywords
    before_save :build_path_before_save

    after_save :homepage_reset

    after_destroy :column_reset

    validates :author_id, presence: true
    validates :content, presence: true, allow_blank: true
    validates :path, uniqueness: true
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true
    validates :title, presence: true

    validate :unique_slug_per_level

    belongs_to :author, class_name: Archangel::User
    belongs_to :assetable, polymorphic: true

    has_many :assets, as: :assetable
    has_many :categorizations, as: :categorizable
    has_many :categories, through: :categorizations
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings

    # Nested attributes
    accepts_nested_attributes_for :categories, reject_if: :all_blank,
                                               allow_destroy: true
    accepts_nested_attributes_for :tags, reject_if: :all_blank,
                                         allow_destroy: true

    default_scope { order(published_at: :desc) }

    # Scope
    scope :published, (lambda do
      where.not(published_at: nil).where("published_at <= ?", Time.now)
    end)

    scope :unpublished, (lambda do
      where("published_at IS NULL OR published_at > ?", Time.now)
    end)

    scope :published_this_month, (lambda do
      where(published_at: Time.now.beginning_of_month..Time.now)
    end)

    scope :homepage, (-> { where(homepage: true) })

    def homepage?
      homepage
    end

    def published?
      published_at.present?
    end

    protected

    def unique_slug_per_level
      return if unique_slug_per_level?

      errors.add(:slug, Archangel.t(:duplicate_slug))
    end

    def parameterize_slug
      self.slug = slug.to_s.downcase.parameterize
    end

    def stringify_meta_keywords
      keywords = parse_keywords(meta_keywords)

      self.meta_keywords = keywords.compact.reject(&:blank?).join(",")
    end

    def build_path_before_save
      parent_path = parent.blank? ? nil : parent.path

      self.path = [parent_path, slug].compact.join("/")
    end

    def homepage_reset
      return unless homepage?

      Page.where(homepage: true)
          .where.not(id: id)
          .update_all(homepage: false)
    end

    def column_reset
      self.slug = "#{Time.current.to_i}_#{slug}"

      save
    end

    def unique_slug_per_level?
      Page.where(parent_id: parent_id, slug: slug).where.not(id: id).empty?
    end

    def parse_keywords(keywords)
      JSON.parse(keywords)
    rescue
      keywords.to_s.split(", ")
    end
  end
end
