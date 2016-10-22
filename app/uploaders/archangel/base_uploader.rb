module Archangel
  class BaseUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def default_url
      ActionController::Base.helpers.asset_path(default_path)
    end

    def extension_whitelist
      Archangel.configuration.image_white_list
    end

    def remove_animation
      manipulate!(&:collapse!) if content_type == "image/gif"
    end

    def image?
      image_formats.include?(file.content_type)
    end

    protected

    def image_formats
      %w(image/jpg image/jpeg image/png image/gif)
    end
  end
end
