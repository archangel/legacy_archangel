CarrierWave.configure do |config|
  # Local file storage
  config.permissions = 0o666
  config.directory_permissions = 0o777
  config.storage = :file

  # Use local file storage for tests
  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end

  unless Rails.env.production?
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false
  end
end
