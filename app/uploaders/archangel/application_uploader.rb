# frozen_string_literal: true

module Archangel
  # Application uploader
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class ApplicationUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    # Path for file uploads
    #
    # @return [String] upload path
    #
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    # URL for file
    #
    # @return [String] file url
    #
    def default_url
      ActionController::Base.helpers.asset_path(default_path)
    end

    # File extension whitelist
    #
    # @return [Array] file extensions
    #
    def extension_whitelist
      Archangel.config.image_white_list
    end

    # Remove animation if file is a gif based on mime type
    #
    def remove_animation
      manipulate!(&:collapse!) if content_type == "image/gif"
    end

    # Check if file is an image based on mime type
    #
    # @return [Boolean] if file
    #
    def image?
      image_formats.include?(file.content_type)
    end

    protected

    def image_formats
      %w[image/gif image/jpeg image/jpg image/png]
    end

    def image_format?(new_file)
      image_formats.include?(new_file.content_type)
    end
  end
end
