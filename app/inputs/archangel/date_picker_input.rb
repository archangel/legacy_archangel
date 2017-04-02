# frozen_string_literal: true

module Archangel
  # Date picker custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class DatePickerInput < SimpleForm::Inputs::Base
    # Input options
    #
    # Wrap the field and add "input-group" HTML classes to and make way for a
    # calendar icon. 
    #
    def input(_wrapper_options)
      template.content_tag(:div, class: "input-group") do
        template.concat @builder.text_field(attribute_name, input_html_options)
        template.concat calendar_addon
      end
    end

    # HTML Input options
    #
    # Add "form-control" and "datepicker" HTML classes to date time picker
    # fields
    #
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
end
