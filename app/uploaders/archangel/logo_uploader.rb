# frozen_string_literal: true

module Archangel
  class LogoUploader < BaseUploader
    def default_path
      "archangel/resources/" + [version_name, "logo.png"].compact.join("_")
    end

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

    def filename
      "logo.#{file.extension}" if original_filename
    end
  end
end
