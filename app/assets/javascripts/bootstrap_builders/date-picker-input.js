$(document).ready(function() {
  methods = {
    // Constructor
    init: function(options) {
      // The hidden Rails-inputs that will get the actual values like year, month, date, hour and minute.
      text_ele = $("input.bb_date_picker, input.bb_date_time_picker", $(@))
      form = text_ele.parents("form").first()

      // Update values on form-submit.
      if (form.length > 0 && form.data("bb-date-picker-input") != "true") {
        form.data("bb-date-picker-input", "true")

        form.submit(function() {
          $(".bb-date-picker-input", this).each(function() {
            $(this).bbDatePickerInput("updateValues")
          })

          return true
        })

      // Update the values when the date is changed or upon blur
      text_ele.on("changeDate blur", function() {
        parents = $(this).parents(".bb-date-picker")

        if (parents.length <= 0) {
          throw "No parents were found"
        }

        parents.first().bbDatePickerInput("updateValues")
      })
    }

    // Parses the date in the input-field and updates all the hidden Rails-inputs from the parsed values.
    updateValues: function() {
      text_ele = $("input.bb_date_picker, input.bb_date_time_picker", $(@))
      year_ele = $(".bb-date-picker-input-year", $(@))
      month_ele = $(".bb-date-picker-input-month", $(@))
      day_ele = $(".bb-date-picker-input-day", $(@))
      hour_ele = $(".bb-date-picker-input-hour", $(@))
      min_ele = $(".bb-date-picker-input-min", $(@))

      if (year_ele.length <= 0) {
        throw "Could not find year element: " + year_ele
      } else if (month_ele.length <= 0) {
        throw "Could not find month element: " + month_ele
      } else if (day_ele.length <= 0) {
        throw "Could not find month element: " + day_ele
      }

      if ($.trim(text_ele.val()) == "") {
        year_ele.val("")
        month_ele.val("")
        day_ele.val("")
        hour_ele.val("")
        min_ele.val("")
      } else if(match = text_ele.val().match(/^\s*(\d+)-(\d+)-(\d+)\s+(\d+):(\d+)\s*$/)) {
        year_ele.val(match[1])
        month_ele.val(match[2])
        day_ele.val(match[3])
        hour_ele.val(match[4])
        min_ele.val(match[5])
      }else if(match = text_ele.val().match(/^\s*(\d+)-(\d+)-(\d+)\s*$/)) {
        year_ele.val(match[1])
        month_ele.val(match[2])
        day_ele.val(match[3])
        hour_ele.val(0)
        min_ele.val(0)
      } else {
        throw "Invalid date-format: '" + text_ele.val() + "'."
      }

      // Set the content to be a date, if this is a date-input-picker.
      if (match && text_ele.hasClass("bb_date_picker")) {
        text_ele.val(match[1] + "-" + match[2] + "-" + match[3])
      }
    }
  }

  // Initialize the plugin.
  $.fn.bbDatePickerInput = function(method) {
    if (methods[method]) {
      methods[method].apply(this, Array::slice.call(arguments, 1))
    } else if (typeof method is "object" or not method) {
      methods.init.apply(this, arguments)
    } else {
      $.error "Method " + method + " does not exist on jquery.inputDatePicker"
    }
  }
)

$(document).ready(function() {
  $(".bb-date-picker").each(function() {
    $(this).bbDatePickerInput()
  })
}
