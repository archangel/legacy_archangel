# frozen_string_literal: true

module Archangel
  # Logo uploader
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class LogoUploader < ApplicationUploader
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

    # Path to default logo file
    #
    # @return [String] path to logo file
    #
    def default_path
      "archangel/resources/" + [version_name, "logo.png"].compact.join("_")
    end

    # Uploaded logo file name
    #
    # @return [String] logo file name
    #
    def filename
      "logo.#{file.extension}" if original_filename
    end
  end
end
