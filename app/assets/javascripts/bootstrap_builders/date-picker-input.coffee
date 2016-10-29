(($, window, document) ->
  $this = undefined
  $text_ele = undefined
  $form = undefined
  $year_ele = undefined
  $month_ele = undefined
  $day_ele = undefined
  $hour_ele = undefined
  $min_ele = undefined

  methods = {
    # Constructor.
    init: (options) ->
      $this = $(@)
      throw "Invalid element given." if $this.length <= 0

      # The hidden Rails-inputs that will get the actual values like year, month, date, hour and minute.
      $text_ele = $("input.bb_date_picker, input.bb_date_time_picker", $this)
      $form = $(this).parents("form").first()
      $year_ele = $(".bb-date-picker-input-year", $this).first()
      $month_ele = $(".bb-date-picker-input-moth", $this).first()
      $day_ele = $(".bb-date-picker-input-day", $this).first()
      $hour_ele = $(".bb-date-picker-input-hour", $this).first()
      $min_ele = $(".bb-date-picker-input-min", $this).first()

      throw "Could not find the year element." if $year_ele.length <= 0

      # Update values on form-submit.
      if $form.length > 0 && $form.data("bb-date-picker-input") != "true"
        $form.data("bb-date-picker-input", "true")

        $form.submit ->
          $(".bb-date-picker-input", this).each ->
            $(this).bbDatePickerInput("updateValues")
          return true

      # Update the values when the date is changed or upon blur
      $text_ele.on "changeDate blur", ->
        console.log "changeDate blur"
        $(this).parents(".bb-date-picker-input").first().bbDatePickerInput("updateValues")

      return $this

    # Parses the date in the input-field and updates all the hidden Rails-inputs from the parsed values.
    updateValues: ->
      # The hidden Rails-inputs that will get the actual values like year, month, date, hour and minute.
      $text_ele = $("input.bb_date_picker, input.bb_date_time_picker", $this)
      throw "No text element?" if $text_ele.length <= 0

      $form = $(this).parents("form").first()
      $year_ele = $(".bb-date-picker-input-year", $this).first()
      $month_ele = $(".bb-date-picker-input-month", $this).first()
      $day_ele = $(".bb-date-picker-input-day", $this).first()
      $hour_ele = $(".bb-date-picker-input-hour", $this).first()
      $min_ele = $(".bb-date-picker-input-min", $this).first()

      if $.trim($text_ele.val()) == ""
        $year_ele.val("")
        $month_ele.val("")
        $day_ele.val("")
        $hour_ele.val("")
        $min_ele.val("")
      else if match = $text_ele.val().match(/^\s*(\d+)-(\d+)-(\d+)\s+(\d+):(\d+)\s*$/)
        $year_ele.val(match[1])
        $month_ele.val(match[2])
        $day_ele.val(match[3])
        $hour_ele.val(match[4])
        $min_ele.val(match[5])
      else if match = $text_ele.val().match(/^\s*(\d+)-(\d+)-(\d+)\s*$/)
        $year_ele.val(match[1])
        $month_ele.val(match[2])
        $day_ele.val(match[3])
        $hour_ele.val(0)
        $min_ele.val(0)
      else
        throw "Invalid date-format: '" + $text_ele.val() + "'."

      # Set the content to be a date, if this is a date-input-picker.
      if match && $text_ele.hasClass("bb_date_picker")
        $text_ele.val(match[1] + "-" + match[2] + "-" + match[3])

      return $this
  }

  # Initialize the plugin.
  $.fn.bbDatePickerInput = (method) ->
    if methods[method]
      methods[method].apply(this, Array::slice.call(arguments, 1))
    else if typeof method is "object" or not method
      methods.init.apply(this, arguments)
    else
      $.error "Method " + method + " does not exist on jquery.inputDatePicker"
) jQuery, window, document

$ ->
  $(".bb-date-picker").each ->
    $(this).bbDatePickerInput()
