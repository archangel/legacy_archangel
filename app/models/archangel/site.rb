# frozen_string_literal: true

module Archangel
  # Site model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Site < ApplicationRecord
    # Uploader
    mount_uploader :logo, Archangel::LogoUploader

    # Callbacks
    before_save :stringify_meta_keywords

    # Validation
    validates :locale, presence: true,
                       inclusion: { in: Archangel::LANGUAGES }
    validates :logo, file_size: {
      less_than_or_equal_to: Archangel.config.image_maximum_file_size
    }
    validates :name, presence: true

    # Scope
    def self.current
      first_or_create { |site| site.name = Archangel.t(:archangel) }
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
