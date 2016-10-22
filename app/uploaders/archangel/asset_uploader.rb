module Archangel
  class AssetUploader < BaseUploader
    def extension_white_list
      Archangel.configuration.attachment_white_list
    end

    def default_path
      type = model.content_type

      if image_formats.include?(type)
        model.file.versions[version_name].url
      else
        "archangel/resources/" + [version_name, "asset.png"].compact.join("_")
      end
    end

    process :save_content_type_and_size_in_model

    version :thumb, if: :image_format? do
      process resize_to_fit: [128, 128]
    end

    version :mini, if: :image_format? do
      process resize_to_fit: [48, 48]
    end

    protected

    def image_format?(new_file)
      image_formats.include?(new_file.content_type)
    end

    def save_content_type_and_size_in_model
      model.content_type = file.content_type if file.content_type
      model.file_size = file.size
    end
  end
end
