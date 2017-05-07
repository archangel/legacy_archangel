# frozen_string_literal: true

module Archangel
  # Asset uploader
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class AssetUploader < ApplicationUploader
    version :thumb, if: :image_format? do
      process resize_to_fit: [128, 128]
    end

    version :mini, if: :image_format? do
      process resize_to_fit: [48, 48]
    end

    # File extension whitelist
    #
    # @return [Array] file extension whitelist
    #
    def extension_whitelist
      Archangel.config.attachment_white_list
    end

    # Path to default avatar file
    #
    # @return [String] path to avatar file
    #
    def default_path
      "archangel/" + [version_name, "asset.png"].compact.join("_")
    end
  end
end
