module Archangel
  class BaseUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def default_url
      ActionController::Base.helpers.asset_path(default_path)
    end

    def default_path
      "archangel/resources/" + [version_name, "default.png"].compact.join("_")
    end

    def extension_white_list
      %w(gif jpeg jpg png)
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
