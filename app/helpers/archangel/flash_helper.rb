module Archangel
  # Flash message helpers
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module FlashHelper
    # Flash message type based on Bootstrap flash types
    #
    # = Example
    #   "<%= flash_class_for('success') %>" #=> "success"
    #   "<%= flash_class_for('error') %>" #=> "danger"
    #   "<%= flash_class_for('alert') %>" #=> "warning"
    #   "<%= flash_class_for('notice') %>" #=> "info"
    #   "<%= flash_class_for('unknown') %>" #=> "unknown"
    #   "<%= flash_class_for('Foo Bar') %>" #=> "foo-bar"
    #
    # @param [String, Symbol] flash_type
    #                         flash message type
    # @return [String] flash message type
    #
    def flash_class_for(flash_type)
      flash_type = flash_type.to_s.downcase.parameterize

      {
        success: "success", error: "danger", alert: "warning", notice: "info"
      }[flash_type.to_sym] || flash_type
    end
  end
end
