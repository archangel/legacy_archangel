require "carrierwave/test/matchers"

RSpec.configure do |config|
  config.include CarrierWave::Test::Matchers, type: :uploader

  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads"])
  end
end

def uploader_test_file
  Archangel::Engine.root + "spec/support/uploads/image.gif"
end
