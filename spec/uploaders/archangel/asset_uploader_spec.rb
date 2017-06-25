# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe AssetUploader, type: :uploader do
    let(:asset) { create(:asset) }
    let(:uploader) { AssetUploader.new(asset, :file) }

    it "allows certain extensions" do
      expect(subject.extension_whitelist).to eq %i[gif jpeg jpg png]
    end

    context "with image file" do
      before do
        Archangel::AssetUploader.enable_processing = true

        uploader.store!(fixture_file_upload(uploader_test_image, "image/gif"))
      end

      after do
        Archangel::AssetUploader.enable_processing = false

        uploader.remove!
      end

      it "is an image file" do
        expect(uploader.image?).to be_truthy
      end

      it "scales a thumb image to be no larger than 128 by 128 pixels" do
        expect(uploader.thumb).to be_no_larger_than(128, 128)
      end

      it "scales a mini image to be no larger than 48 by 48 pixels" do
        expect(uploader.mini).to be_no_larger_than(48, 48)
      end

      it "makes the image with 666 permissions" do
        expect(uploader).to have_permissions(0o666)
      end
    end

    context "with non-image file" do
      before do
        Archangel.config.asset_white_list.insert(0, "txt")

        Archangel::AssetUploader.enable_processing = true

        uploader.store!(fixture_file_upload(uploader_test_image, "text/plain"))
      end

      after do
        Archangel.config.asset_white_list.delete_at(0)

        Archangel::AssetUploader.enable_processing = false

        uploader.remove!
      end

      it "is not an image file" do
        expect(uploader.image?).to be_falsey
      end

      it "makes the image with 666 permissions" do
        expect(uploader).to have_permissions(0o666)
      end
    end
  end
end
