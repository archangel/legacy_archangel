# frozen_string_literal: true

module Archangel
  # Post model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Post < ApplicationRecord
    acts_as_paranoid

    before_validation :parameterize_slug

    before_save :stringify_meta_keywords
    before_save :build_path_before_save

    after_destroy :column_reset

    mount_uploader :feature, Archangel::FeatureUploader

    validates :author_id, presence: true
    validates :content, presence: true, allow_blank: true
    validates :path, uniqueness: true
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true
    validates :title, presence: true

    belongs_to :author, class_name: Archangel::User

    has_many :categorizations, as: :categorizable
    has_many :categories, through: :categorizations
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings

    accepts_nested_attributes_for :categories, reject_if: :all_blank,
                                               allow_destroy: true
    accepts_nested_attributes_for :tags, reject_if: :all_blank,
                                         allow_destroy: true

    default_scope { order(published_at: :desc, id: :desc) }

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

    scope :with_category, lambda { |category|
      joins(:categories).where("archangel_categories.slug = ?", category)
    }

    scope :with_tag, lambda { |tag|
      joins(:tags).where("archangel_tags.slug = ?", tag)
    }

    # Next post
    #
    # Next post based on current posts publication date
    #
    # = Example
    #   "<% next = @post.next %>" #=> Archangel::Post
    #
    # @return [Object] next post
    #                  next post based on published_at
    #
    def next
      return nil unless published_at

      self.class.where("published_at > ?", published_at).first
    end

    # Previous post
    #
    # Previous post based on current posts publication date
    #
    # = Example
    #   "<% previous = @post.previous %>" #=> Archangel::Post
    #
    # @return [Object] previous post
    #                  previous post based on published_at
    #
    def previous
      return nil unless published_at

      self.class.where("published_at < ?", published_at).last
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
      year = published_at ? published_at.year : nil
      month = published_at ? format("%02d", published_at.month) : nil

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
