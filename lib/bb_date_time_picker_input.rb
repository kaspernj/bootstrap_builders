# Create an input-text-field with a date-time-picker widget attached. Also makes sure the given date-time-value is being put in the correct format.
class BbDateTimePickerInput < SimpleForm::Inputs::Base
  # The method that should return the widgets HTML based on the sat arguments.
  def input(_wrapper_options)
    # Parse the value.
    if input_html_options[:value]
      date = input_html_options[:value]
    elsif @builder.object.present?
      date = @builder.object.send(attribute_name)
    else
      date = nil
    end

    if date.present?
      val = date.strftime("%Y-%m-%d")

      year = date.year
      month = date.month
      day = date.day
      hour = date.hour
      min = date.min
    end

    # Parse classes.
    classes = ["form-control"]

    class_arg = input_html_options[:class]

    if class_arg
      if class_arg.is_a?(Array)
        classes += class_arg
      else
        classes << class_arg
      end
    end

    # Generate and return HTML for the widget.
    content_tag = template.content_tag(:div, class: "bb-date-picker") do
      html = ""
      html << @builder.hidden_field("#{attribute_name}(1i)", value: year, class: "bb-date-picker-input-year")
      html << @builder.hidden_field("#{attribute_name}(2i)", value: month, class: "bb-date-picker-input-month")
      html << @builder.hidden_field("#{attribute_name}(3i)", value: day, class: "bb-date-picker-input-day")
      hour = date.hour
      min = date.min
      html << @builder.hidden_field("#{attribute_name}(4i)", value: hour, class: "bb-date-picker-input-hour")
      html << @builder.hidden_field("#{attribute_name}(5i)", value: min, class: "bb-date-picker-input-min")

      html << template.text_field_tag("", val, class: classes, data: {date_format: "yyyy-mm-dd", provide: "datepicker"})

      html.html_safe
    end

    content_tag
  end
end
