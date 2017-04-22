# frozen_string_literal: true

require "carrierwave/test/matchers"

RSpec.configure do |config|
  include ActionDispatch::TestProcess

  config.include CarrierWave::Test::Matchers, type: :uploader

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
  end
end

# Image file to be used for testing image file uploads
#
# @return [String] path to image file
#
def uploader_test_image
  Archangel::Engine.root + "lib/archangel/testing_support/fixtures/image.gif"
end

# Text file to be used for testing non-image file uploads
#
# @return [String] path to non-image file
#
def uploader_test_text
  Archangel::Engine.root + "lib/archangel/testing_support/fixtures/text.txt"
end

# PNG file to be used for testing favicon file uploads
#
# @return [String] path to favicon file
#
def uploader_test_favicon
  Archangel::Engine.root + "lib/archangel/testing_support/fixtures/favicon.png"
end
