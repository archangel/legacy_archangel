# frozen_string_literal: true

module Archangel
  # Application configurations
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Configuration
    # Default value
    #
    # Default value to return when key isn't set
    #
    DEFAULT_VALUE = nil

    # Admin path
    #
    # Path for admin area. Default is "admin"
    #
    # = Options
    #   [String] admin_path admin path
    #
    attr_reader :admin_path

    # Allow registration
    #
    # Allow registration. Default is `false`
    #
    # = Option allow_registration sallow registration paths
    #
    attr_reader :allow_registration

    # Application name
    #
    # Short name. Default is "archangel"
    #
    # = Options
    #   [String] application application name
    #
    attr_reader :application

    # Asset maximum file size
    #
    # Maximum file size of assets. Default is `2.megabytes`
    #
    # = Options
    #   [Integer] asset_maximum_file_size maximum file size
    #
    attr_reader :asset_maximum_file_size

    # Asset file extension whitelist
    #
    # Asset file extension whitelist. Default is `%w(gif jpeg jpg png)`
    #
    # = Options
    #   [Array] asset_white_list file extensions whitelist
    #
    attr_reader :asset_white_list

    # Auth path
    #
    # Path for auth area. Default is "account"
    #
    # = Options
    #   [String] auth_path auth path
    #
    attr_reader :auth_path

    # Frontend path
    #
    # Path for frontend. Default is ""
    #
    # = Options
    #   [String] frontend_path frontend path
    #
    attr_reader :frontend_path

    # Image maximum file size
    #
    # Maximum file size of images. Default is `2.megabytes`
    #
    # = Options
    #   [Integer] image_maximum_file_size maximum file size
    #
    attr_reader :image_maximum_file_size

    # Image whitelist
    #
    # Image file extension whitelist. Default is `%w(gif jpeg jpg png)`
    #
    # = Options
    #   [Array] image_white_list image file extensions
    #
    attr_reader :image_white_list

    # Posts path
    #
    # Path for blog posts. Default is "posts"
    #
    # = Options
    #   [String] posts_path frontend posts path
    #
    attr_reader :posts_path

    def initialize
      max_file_size = 2.megabytes
      image_file_whitelist = %w[gif jpeg jpg png]

      @admin_path = "admin"
      @allow_registration = false
      @application = "archangel"
      @asset_maximum_file_size = max_file_size
      @asset_white_list = image_file_whitelist
      @auth_path = "account"
      @frontend_path = ""
      @image_maximum_file_size = max_file_size
      @image_white_list = image_file_whitelist
      @posts_path = "posts"
    end

    protected

    def respond_to_missing?
      super
    end

    def method_missing(method_name, *args)
      super
    rescue NoMethodError
      method = method_name.to_s

      if method[-1] == "?"
        column = method.sub("?", "")

        send(column.to_sym, *args) != DEFAULT_VALUE
      else
        DEFAULT_VALUE
      end
    end
  end
end
