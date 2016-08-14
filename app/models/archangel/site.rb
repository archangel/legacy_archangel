module Archangel
  class Site < ApplicationRecord
    # Uploader
    mount_uploader :logo, Archangel::LogoUploader

    # Callbacks
    before_save :stringify_meta_keywords

    # Validation
    validates :name, presence: true
    validates :locale, presence: true,
                       inclusion: { in: Archangel::LANGUAGES }

    # Scope
    def self.current
      first_or_create do |site|
        site.name = Archangel.t(:archangel)
      end
    end

    protected

    def stringify_meta_keywords
      keywords = JSON.parse(meta_keywords) rescue meta_keywords.to_s.split(",")

      self.meta_keywords = keywords.compact.reject(&:blank?).join(",")
    end
  end
end
