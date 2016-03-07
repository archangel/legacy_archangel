class DateTimePickerInput < DatePickerInput
  def input_html_options
    super.merge(class: "form-control datetimepicker")
  end
end


# class DateTimePickerInput < SimpleForm::Inputs::Base
#   def input
#     template.content_tag(:div, class: "input-group") do
#       template.concat @builder.text_field(attribute_name, input_html_options)
#       template.concat remove_addon unless required_field?
#       template.concat calendar_addon
#     end
#   end
#
#   def input_html_options
#     super.merge(class: "form-control datetimepicker")
#   end
#
#   protected
#
#   def remove_addon
#     template.content_tag(:span, class: "input-group-addon datetimepicker-remove") do
#       template.concat icon_calendar
#     end
#   end
#
#   def calendar_addon
#     template.content_tag(:span, class: "input-group-addon") do
#       template.concat icon_calendar
#     end
#   end
#
#   def icon_remove
#     "<i class='glyphicon glyphicon-remove'></i>".html_safe
#   end
#
#   def icon_calendar
#     "<i class='glyphicon glyphicon-th'></i>".html_safe
#   end
# end
