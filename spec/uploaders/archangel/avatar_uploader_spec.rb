require "rails_helper"

module Archangel
  RSpec.describe AvatarUploader, type: :uploader do
    let(:user) { create(:user) }
    let(:uploader) { AvatarUploader.new(user, :avatar) }

    before do
      Archangel::AvatarUploader.enable_processing = true

      File.open(uploader_test_image) { |file| uploader.store!(file) }
    end

    after do
      Archangel::AvatarUploader.enable_processing = false

      uploader.remove!
    end

    it "scales an image to be no larger than 512 by 512 pixels" do
      expect(uploader).to be_no_larger_than(512, 512)
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

    it "scales a mini image to be no larger than 24 by 24 pixels" do
      expect(uploader.micro).to be_no_larger_than(24, 24)
    end

    it "makes the image with 666 permissions" do
      expect(uploader).to have_permissions(0o666)
    end
  end
end
