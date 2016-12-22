require "rails_helper"

module Archangel
  RSpec.describe FeatureUploader, type: :uploader do
    let(:site) { create(:site) }
    let(:uploader) { FeatureUploader.new(site, :feature) }

    before do
      Archangel::FeatureUploader.enable_processing = true

      File.open(uploader_test_image) { |f| uploader.store!(f) }
    end

    after do
      Archangel::FeatureUploader.enable_processing = false

      uploader.remove!
    end

    it "scales a medium image to be no larger than 256 by 256 pixels" do
      expect(uploader.medium).to be_no_larger_than(256, 256)
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
end
