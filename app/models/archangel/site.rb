module Archangel
  class Site < ApplicationRecord
    # Uploader
    mount_uploader :logo, Archangel::LogoUploader

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
  end
end
