# frozen_string_literal: true

require "anyway"

module Archangel
  # Application configurations
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Config < Anyway::Config
    config_name :archangel

    attr_config admin_path: "admin",
                allow_registration: false,
                application: "archangel",
                asset_maximum_file_size: 2.megabytes,
                asset_white_list: %i[gif jpeg jpg png],
                auth_path: "account",
                frontend_path: "",
                image_maximum_file_size: 2.megabytes,
                image_white_list: %i[gif jpeg jpg png],
                posts_path: "posts"
  end
end
