module Archangel
  class AvatarUploader < BaseUploader
    def default_path
      "archangel/fallback/" + [version_name, "avatar.jpg"].compact.join("_")
    end

    process :remove_animation

    version :medium do
      process resize_to_fit: [256, 256]
    end

    version :thumb do
      process resize_to_fit: [144, 144]
    end

    version :mini do
      process resize_to_fit: [48, 48]
    end

    def filename
      "avatar.#{file.extension}" if original_filename
    end
  end
end
