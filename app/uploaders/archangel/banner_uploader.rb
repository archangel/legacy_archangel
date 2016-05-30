module Archangel
  class BannerUploader < BaseUploader
    def default_path
      "archangel/fallback/" + [version_name, "banner.jpg"].compact.join("_")
    end

    version :thumb do
      process resize_to_fit: [144, 144]
    end

    version :mini do
      process resize_to_fit: [48, 48]
    end

    def filename
      "banner.#{file.extension}" if original_filename
    end
  end
end
