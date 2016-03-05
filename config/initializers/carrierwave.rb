CarrierWave.configure do |config|
  # Local file storage
  config.permissions = 0666
  config.directory_permissions = 0777
  config.storage = :file

  # Use local file storage for tests
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
end
