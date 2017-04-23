# frozen_string_literal: true

module Archangel
  # Site model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Site < ApplicationRecord
    # Uploader
    mount_uploader :favicon, Archangel::FaviconUploader
    mount_uploader :logo, Archangel::LogoUploader

    before_save :stringify_meta_keywords

    validates :locale, presence: true,
                       inclusion: { in: Archangel::LANGUAGES }
    validates :logo, file_size: {
      less_than_or_equal_to: Archangel.config.image_maximum_file_size
    }
    validates :name, presence: true
    validates :theme, presence: true, inclusion: { in: Archangel.themes }

    # Current site
    #
    # First available record in the `sites` table is considered the current
    # site. A site may or may not exist. If a record doesn't exist, a site is
    # created using default values.
    #
    # @return [Object] current site
    #                  next post based on published_at
    #
    def self.current
      first_or_create do |site|
        site.name = Archangel.t(:archangel)
        site.theme = Archangel::THEME_DEFAULT
      end
    end

    protected

    def stringify_meta_keywords
      keywords = parse_keywords(meta_keywords)

      self.meta_keywords = keywords.compact.reject(&:blank?).join(",")
    end

    def parse_keywords(keywords)
      JSON.parse(keywords)
    rescue
      keywords.to_s.split(",")
    end
  end
end
