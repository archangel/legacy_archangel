class DateTimePickerInput < DatePickerInput
  def input_html_options
    super.merge(class: "form-control datetimepicker")
  end
end
