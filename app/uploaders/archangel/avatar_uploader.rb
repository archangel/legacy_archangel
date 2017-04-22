# frozen_string_literal: true

module Archangel
  # Logo uploader
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class AvatarUploader < ApplicationUploader
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

    # Path to default avatar file
    #
    # @return [String] path to avatar file
    #
    def default_path
      "archangel/" + [version_name, "avatar.jpg"].compact.join("_")
    end

    # Uploaded avatar file name
    #
    # @return [String] avatar file name
    #
    def filename
      "avatar.#{file.extension}" if original_filename
    end
  end
end
