module Archangel
  class LogoUploader < BaseUploader
    def default_path
      "archangel/fallback/" + [version_name, "logo.png"].compact.join("_")
    end

    process resize_to_fit: [256, 256]

    version :thumb do
      process resize_to_fit: [144, 144]
    end

    version :mini do
      process resize_to_fit: [48, 48]
    end

    def filename
      "logo.#{file.extension}" if original_filename
    end
  end
end
