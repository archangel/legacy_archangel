# frozen_string_literal: true

module Archangel
  # Favicon uploader
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class FaviconUploader < ApplicationUploader
    process resize_to_fit: [32, 32]
    process convert: :ico

    # Path to default logo file
    #
    # @return [String] path to logo file
    #
    def default_path
      "archangel/" + [version_name, "favicon.ico"].compact.join("_")
    end

    # Uploaded favicon file name
    #
    # @return [String] favicon file name
    #
    def filename
      "favicon.ico" if original_filename
    end
  end
end
