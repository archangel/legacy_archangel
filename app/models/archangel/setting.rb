module Archangel
  class Setting < ActiveRecord::Base
    # Uploader
    mount_uploader :logo, Archangel::LogoUploader

    # Validation
    validates :title, presence: true
    validates :per_page, numericality: { only_integer: true,
                                         greater_than: 0,
                                         less_than_or_equal_to: 500 }

    # Scope
    def self.settings
      first_or_create do |setting|
        setting.title = Archangel.t(:archangel)
        setting.per_page = 24
      end
    end
  end
end
