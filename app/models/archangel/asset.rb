# frozen_string_literal: true

module Archangel
  # Asset model
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Asset < ApplicationRecord
    before_save :save_asset_attributes

    mount_uploader :file, Archangel::AssetUploader

    belongs_to :assetable, polymorphic: true, optional: true
    belongs_to :page, optional: true
    belongs_to :uploader, class_name: "Archangel::User"

    validates :file, presence: true,
                     file_size: {
                       greater_than_or_equal_to: 2.bytes,
                       less_than_or_equal_to:
                         Archangel.config.asset_maximum_file_size
                     }

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
