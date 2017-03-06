# frozen_string_literal: true

# Time picker custom simple_form input field
#
# @author dfreerksen
# @since 0.0.1
#
class TimePickerInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    template.content_tag(:div, class: "input-group") do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat calendar_addon
    end
  end

  def input_html_options
    super.merge(class: "form-control timepicker")
  end

  protected

  def calendar_addon
    template.content_tag(:span, class: "input-group-addon") do
      template.concat icon_calendar
    end
  end

  def icon_calendar
    "<i class='glyphicon glyphicon-timestamp'></i>".html_safe
  end
end
