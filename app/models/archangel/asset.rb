# frozen_string_literal: true

module Archangel
  # Asset model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Asset < ApplicationRecord
    # Callbacks
    before_save :save_asset_attributes

    # Uploader
    mount_uploader :file, Archangel::AssetUploader

    # Associations
    belongs_to :page
    belongs_to :assetable, polymorphic: true
    belongs_to :uploader, class_name: Archangel::User

    # Validation
    validates :file, presence: true,
                     file_size: {
                       greater_than_or_equal_to: 2.bytes,
                       less_than_or_equal_to:
                         Archangel.config.attachment_maximum_file_size
                     }

    # Default scope
    default_scope { order(created_at: :desc) }

    protected

    def save_asset_attributes
      return unless file.present? && file_changed?

      asset_object = file.file

      self.content_type = asset_object.content_type
      self.file_size = asset_object.size
    end
  end
end
