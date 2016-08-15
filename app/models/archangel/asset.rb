module Archangel
  class Asset < ApplicationRecord
    # Uploader
    mount_uploader :file, Archangel::AssetUploader

    # Associations
    belongs_to :page
    belongs_to :assetable, polymorphic: true
    belongs_to :uploader, class_name: Archangel::User
  end
end
