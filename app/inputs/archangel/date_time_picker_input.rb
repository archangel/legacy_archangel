# frozen_string_literal: true

module Archangel
  # Date and time custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class DateTimePickerInput < DatePickerInput
    # HTML Input options
    #
    # Add "form-control" and "datetimepicker" HTML classes to date time picker
    # fields
    #
    def input_html_options
      super.merge(class: "form-control datetimepicker")
    end
  end
end
