Archangel.configure do |config|
  # Maximum file size of attachments for upload.
  # Default is 2.megabytes
  # config.attachment_maximum_file_size = 2.megabytes

  # File types available for upload for issue attachments.
  # Default is %w(jpg jpeg gif png pdf)
  # config.attachment_white_list = %w(jpg jpeg gif png pdf)

  # Application.
  # Default is "archangel"
  config.application = "archangel"
end
