# frozen_string_literal: true

# Date and time custom simple_form input field
#
# @author dfreerksen
# @since 0.0.1
#
class DateTimePickerInput < DatePickerInput
  def input_html_options
    super.merge(class: "form-control datetimepicker")
  end
end
