# frozen_string_literal: true

module Archangel
  # Application configurations
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class Configuration
    DEFAULT_VALUE = nil

    attr_reader :admin_path, :application, :attachment_maximum_file_size,
                :attachment_white_list, :auth_path, :frontend_path,
                :image_maximum_file_size, :image_white_list, :posts_path

    def initialize
      max_file_size = 2.megabytes

      @admin_path = "admin"
      @application = "archangel"
      @attachment_maximum_file_size = max_file_size
      @attachment_white_list = %w[gif jpeg jpg png]
      @auth_path = "account"
      @frontend_path = ""
      @image_maximum_file_size = max_file_size
      @image_white_list = %w[gif jpeg jpg png]
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
