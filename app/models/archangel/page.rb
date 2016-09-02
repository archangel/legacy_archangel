module Archangel
  class Page < ApplicationRecord
    extend ActsAsTree::TreeView

    acts_as_tree order: :title
    acts_as_paranoid

    # Callbacks
    before_validation :parameterize_slug
    before_save :stringify_meta_keywords
    before_save :build_path_before_save
    after_destroy :column_reset

    # Validation
    validates :author_id, presence: true
    validates :content, presence: true, allow_blank: true
    validates :path, uniqueness: true
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true
    validates :title, presence: true

    validate :unique_slug_per_level

    # Associations
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

    # Default scope
    default_scope { order(published_at: :desc) }

    # Scope
    scope :published, -> { where("published_at <= ?", Time.now) }

    scope :unpublished, lambda {
      where("published_at IS NULL OR published_at > ?", Time.now)
    }

    scope :in_year, lambda { |year|
      unless year.nil?
        where("cast(strftime('%Y', published_at) as int) = ?", year)
      end
    }

    scope :in_month, lambda { |month|
      unless month.nil?
        where("cast(strftime('%m', published_at) as int) = ?", month)
      end
    }

    scope :in_year_and_month, ->(year, month) { in_month(month).in_year(year) }

    scope :published_this_month, lambda {
      where(published_at: Time.now.beginning_of_month..Time.now)
    }

    protected

    def unique_slug_per_level
      unless unique_slug_per_level?
        errors.add(:slug, Archangel.t("errors.duplicate_slug"))
      end
    end

    def parameterize_slug
      self.slug = slug.to_s.downcase.parameterize
    end

    def stringify_meta_keywords
      keywords = parse_keywords(meta_keywords)

      self.meta_keywords = keywords.compact.reject(&:blank?).join(",")
    end

    def build_path_before_save
      parent_path = parent.nil? ? nil : parent.path

      self.path = [parent_path, slug].compact.join("/")
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
      keywords.to_s.split(",")
    end
  end
end
