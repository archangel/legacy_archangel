module Archangel
  class AssetUploader < BaseUploader
    def extension_white_list
      Archangel.configuration.attachment_white_list
    end

    def default_path
      "archangel/resources/" + [version_name, "asset.png"].compact.join("_")
    end

    def type_url
      type = model.content_type

      if image_formats.include?(type)
        model.file.versions[version_name].url
      else
        format_path("asset.png")
      end
    end

    process :save_content_type_and_size_in_model

    version :thumb do
      process resize_to_fit: [128, 128]
    end

    version :mini do
      process resize_to_fit: [48, 48]
    end

    protected

    def format_path(asset)
      "archangel/resources/mime/" + [version_name, asset].compact.join("_")
    end

    def save_content_type_and_size_in_model
      model.content_type = file.content_type if file.content_type
      model.file_size = file.size
    end
  end
end
