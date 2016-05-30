module Archangel
  class Post < ActiveRecord::Base
    acts_as_paranoid

    # Callbacks
    before_validation :parameterize_slug
    after_destroy :column_reset

    # Uploader
    mount_uploader :banner, Archangel::BannerUploader

    # Validation
    validates :author_id, presence: true
    validates :content, presence: true, allow_blank: true
    validates :excerpt, presence: true, allow_blank: true
    validates :published_at, allow_blank: true, date: true
    validates :slug, presence: true, length: { maximum: 24 }
    validates :title, presence: true

    # Associations
    belongs_to :author, class_name: Archangel::User

    # Default scope
    default_scope { order(published_at: :desc) }

    # Scope
    scope :published, -> {
      where("published_at <= ?", Time.now)
    }

    scope :unpublished, -> {
      where("published_at IS NULL OR published_at > ?",  Time.now)
    }

    scope :in_year, ->(year) {
      unless year.nil?
        where("cast(strftime('%Y', published_at) as int) = ?", year)
      end
    }

    scope :in_month, ->(month) {
      unless month.nil?
        where("cast(strftime('%m', published_at) as int) = ?", month)
      end
    }

    scope :in_year_and_month, ->(year, month) {
      in_month(month).in_year(year)
    }

    scope :published_this_month, -> {
      where(published_at: Time.now.beginning_of_month..Time.now)
    }

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
