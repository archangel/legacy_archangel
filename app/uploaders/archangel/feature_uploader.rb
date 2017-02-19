# frozen_string_literal: true

module Archangel
  class FeatureUploader < BaseUploader
    def default_path
      "archangel/resources/" + [version_name, "feature.jpg"].compact.join("_")
    end

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
      "feature.#{file.extension}" if original_filename
    end
  end
end
