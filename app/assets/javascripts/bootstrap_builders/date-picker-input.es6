class DatePickerInput {
  constructor(options) {
    var current_input = this

    this.element = options.element
    this.text_ele = $("input.bb_date_picker, input.bb_date_time_picker", this.element)
    this.form = this.text_ele.parents("form").first()

    // The hidden Rails-inputs that will get the actual values like year, month, date, hour and minute.
    this.text_ele = $("input.bb_date_picker, input.bb_date_time_picker", this.element)
    this.year_ele = $(".bb-date-picker-input-year", this.element)
    this.month_ele = $(".bb-date-picker-input-month", this.element)
    this.day_ele = $(".bb-date-picker-input-day", this.element)
    this.hour_ele = $(".bb-date-picker-input-hour", this.element)
    this.min_ele = $(".bb-date-picker-input-min", this.element)

    // Update values on form-submit.
    if (this.form.length > 0 && this.form.data("bb-date-picker-input") != "true") {
      this.form.data("bb-date-picker-input", "true")

      this.form.submit(function() {
        $(".bb-date-picker-input", this).each(function() {
          $(this).bbDatePickerInput("updateValues")
        })

        return true
      })
    }

    // Update the values when the date is changed or upon blur
    this.text_ele.on("changeDate blur", function() {
      var parents = $(this).parents(".bb-date-picker")

      if (parents.length <= 0) {
        throw "No parents were found"
      }

      current_input.updateValues()
    })
  }

  // Parses the date in the input-field and updates all the hidden Rails-inputs from the parsed values.
  updateValues() {
    if (this.year_ele.length <= 0) {
      throw "Could not find year element: " + this.year_ele
    } else if (this.month_ele.length <= 0) {
      throw "Could not find month element: " + this.month_ele
    } else if (this.day_ele.length <= 0) {
      throw "Could not find month element: " + this.day_ele
    }

    var match = null

    if ($.trim(this.text_ele.val()) == "") {
      this.year_ele.val("")
      this.month_ele.val("")
      this.day_ele.val("")
      this.hour_ele.val("")
      this.min_ele.val("")
    } else if(match = this.text_ele.val().match(/^\s*(\d+)-(\d+)-(\d+)\s+(\d+):(\d+)\s*$/)) {
      this.year_ele.val(match[1])
      this.month_ele.val(match[2])
      this.day_ele.val(match[3])
      this.hour_ele.val(match[4])
      this.min_ele.val(match[5])
    }else if(match = this.text_ele.val().match(/^\s*(\d+)-(\d+)-(\d+)\s*$/)) {
      this.year_ele.val(match[1])
      this.month_ele.val(match[2])
      this.day_ele.val(match[3])
      this.hour_ele.val(0)
      this.min_ele.val(0)
    } else {
      throw "Invalid date-format: '" + this.text_ele.val() + "'."
    }

    // Set the content to be a date, if this is a date-input-picker.
    if (match && this.text_ele.hasClass("bb_date_picker")) {
      this.text_ele.val(match[1] + "-" + match[2] + "-" + match[3])
    }
  }
}

$(document).ready(function() {
  $(".bb-date-picker").each(function() {
    new DatePickerInput({element: $(this)})
  })
})
