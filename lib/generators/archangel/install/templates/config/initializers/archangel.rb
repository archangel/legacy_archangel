# frozen_string_literal: true

Archangel.configure do |config|
  # Admin path.
  # Default is "admin"
  # config.admin_path = "admin"

  # Auth path.
  # Default is "account"
  # config.auth_path = "account"

  # Posts path.
  # Default is "posts"
  # config.posts_path = "posts"

  # Application name.
  # Default is "archangel"
  # config.application = "archangel"

  # Maximum file size of assets for upload.
  # Default is 2.megabytes
  # config.asset_maximum_file_size = 2.megabytes

  # File upload extensions of attachments for upload.
  # Default is %w(jpg jpeg gif png)
  # config.attachment_white_list = %w(gif jpg jpeg png)
end
