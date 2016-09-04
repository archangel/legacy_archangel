module Archangel
  class Asset < ApplicationRecord
    # Uploader
    mount_uploader :file, Archangel::AssetUploader

    # Associations
    belongs_to :page
    belongs_to :assetable, polymorphic: true
    belongs_to :uploader, class_name: Archangel::User

    # Validation
    validates :file, presence: true, file_size: {
      # file_content_type: Archangel.configuration.attachment_white_list,
      # less_than_or_equal_to:
      #   Archangel.configuration.attachment_maximum_file_size

      file_content_type: %w(jpg jpeg gif png),
      less_than_or_equal_to: 2.megabytes
    }

    # Default scope
    default_scope { order(created_at: :desc) }
  end
end
