module Archangel
  class AssetUploader < BaseUploader
    def default_path
      "archangel/resources/" + [version_name, "asset.png"].compact.join("_")
    end

    process :set_content_type
    process :save_content_type_and_size_in_model

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

    protected

    def save_content_type_and_size_in_model
      model.content_type = file.content_type if file.content_type
      model.file_size = file.size
    end
  end
end
