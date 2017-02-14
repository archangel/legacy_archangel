# frozen_string_literal: true

module Archangel
  class AssetUploader < BaseUploader
    def extension_whitelist
      Archangel.configuration.attachment_white_list
    end

    def default_path
      "archangel/resources/" + [version_name, "asset.png"].compact.join("_")
    end

    version :thumb, if: :image_format? do
      process resize_to_fit: [128, 128]
    end

    version :mini, if: :image_format? do
      process resize_to_fit: [48, 48]
    end

    protected

    def image_format?(new_file)
      image_formats.include?(new_file.content_type)
    end
  end
end
