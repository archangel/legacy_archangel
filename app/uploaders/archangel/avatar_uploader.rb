# frozen_string_literal: true

module Archangel
  class AvatarUploader < BaseUploader
    def default_path
      "archangel/resources/" + [version_name, "avatar.jpg"].compact.join("_")
    end

    process :remove_animation

    process resize_to_fit: [512, 512]

    version :medium do
      process resize_to_fit: [256, 256]
    end

    version :thumb do
      process resize_to_fit: [128, 128]
    end

    version :mini do
      process resize_to_fit: [48, 48]
    end

    version :micro do
      process resize_to_fit: [24, 24]
    end

    def filename
      "avatar.#{file.extension}" if original_filename
    end
  end
end
