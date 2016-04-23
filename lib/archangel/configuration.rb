module Archangel
  class Configuration
    DEFAULT_VALUE = nil

    attr_accessor :admin_path, :application, :attachment_maximum_file_size

    def initialize
      @admin_path = "admin"
      @application = "archangel"
      @attachment_maximum_file_size = 2.megabytes
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
