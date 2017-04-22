# frozen_string_literal: true

module Archangel
  # Post model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Post < ApplicationRecord
    acts_as_paranoid

    # Callbacks
    before_validation :parameterize_slug

    before_save :stringify_meta_keywords
    before_save :build_path_before_save

    after_destroy :column_reset

    # Uploader
    mount_uploader :feature, Archangel::FeatureUploader

    # Validation
    validates :author_id, presence: true
    validates :content, presence: true, allow_blank: true
    validates :path, uniqueness: true
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true
    validates :title, presence: true

    # Associations
    belongs_to :author, class_name: Archangel::User

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
    default_scope { order(published_at: :desc, id: :desc) }

    # Scope
    scope :published, (-> { where("published_at <= ?", Time.now) })

    scope :unpublished, (lambda do
      where("published_at IS NULL OR published_at > ?", Time.now)
    end)

    scope :in_year, (lambda do |year|
      unless year.nil?
        where("cast(strftime('%Y', published_at) as int) = ?", year)
      end
    end)

    scope :in_month, (lambda do |month|
      unless month.nil?
        where("cast(strftime('%m', published_at) as int) = ?", month)
      end
    end)

    scope :in_year_and_month, (lambda do |year, month|
      in_month(month).in_year(year)
    end)

    scope :with_category, (lambda do |category|
      joins(:categories).where("archangel_categories.slug = ?", category)
    end)

    scope :with_tag, (lambda { |tag|
      joins(:tags).where("archangel_tags.slug = ?", tag)
    })

    def next
      return nil unless published_at?

      self.class.where("published_at > ?", published_at).first
    end

    def previous
      return nil unless published_at?

      self.class.where("published_at < ?", published_at).last
    end

    def published?
      published_at.present?
    end

    protected

    def parameterize_slug
      self.slug = slug.to_s.downcase.parameterize
    end

    def stringify_meta_keywords
      keywords = parse_keywords(meta_keywords)

      self.meta_keywords = keywords.compact.reject(&:blank?).join(",")
    end

    def build_path_before_save
      year = published? ? published_at.year : nil
      month = published? ? format("%02d", published_at.month) : nil

      self.path = [year, month, slug].compact.join("/")
    end

    def column_reset
      self.slug = "#{Time.current.to_i}_#{slug}"

      save
    end

    def parse_keywords(keywords)
      JSON.parse(keywords)
    rescue
      keywords.to_s.split(",")
    end
  end
end
