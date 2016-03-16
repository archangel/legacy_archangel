module Archangel
  class Site < ActiveRecord::Base
    # Uploader
    mount_uploader :logo, Archangel::LogoUploader

    # Validation
    validates :title, presence: true

    # Scope
    def self.current
      first_or_create do |site|
        site.title = Archangel.t(:archangel)
      end
    end
  end
end