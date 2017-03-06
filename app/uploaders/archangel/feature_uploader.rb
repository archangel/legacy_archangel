# frozen_string_literal: true

module Archangel
  # Feature uploader
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class FeatureUploader < ApplicationUploader
    version :medium do
      process resize_to_fit: [256, 256]
    end

    version :thumb do
      process resize_to_fit: [128, 128]
    end

    version :mini do
      process resize_to_fit: [48, 48]
    end

    # Path to default feature file
    #
    # @return [String] path to feature file
    #
    def default_path
      "archangel/resources/" + [version_name, "feature.jpg"].compact.join("_")
    end

    # Uploaded feature file name
    #
    # @return [String] feature file name
    #
    def filename
      "feature.#{file.extension}" if original_filename
    end
  end
end
