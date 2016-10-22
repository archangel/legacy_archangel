module Archangel
  class Settings
    DEFAULT_VALUE = nil

    attr_accessor :admin_path, :application, :attachment_maximum_file_size,
                  :attachment_white_list, :auth_path, :image_maximum_file_size,
                  :image_white_list

    def initialize
      @admin_path = "admin"
      @application = "archangel"
      @attachment_maximum_file_size = 2.megabytes
      @attachment_white_list = %w(gif jpeg jpg png)
      @auth_path = "account"
      @image_maximum_file_size = 2.megabytes
      @image_white_list = %w(gif jpeg jpg png)
    end

    def method_missing(method_name, *args)
      super(method_name, *args)
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
