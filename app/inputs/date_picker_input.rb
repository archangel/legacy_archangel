class DatePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: "input-group") do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat calendar_addon
    end
  end

  def input_html_options
    super.merge(class: "form-control datepicker")
  end

  protected

  def calendar_addon
    template.content_tag(:span, class: "input-group-addon") do
      template.concat icon_calendar
    end
  end

  def icon_calendar
    "<i class='glyphicon glyphicon-calendar'></i>".html_safe
  end
end