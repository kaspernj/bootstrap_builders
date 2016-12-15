module BootstrapBuilders::CapybaraSpecHelpers
  def set_bb_date_input(css_identifier, time)
    element = find(css_identifier)

    within element do
      find(".bb-date-picker-input-year", visible: false).set(time.year)
      find(".bb-date-picker-input-month", visible: false).set(time.month)
      find(".bb-date-picker-input-day", visible: false).set(time.day)

      if element[:class].include?("bb_date_time_picker")
        find(".bb-date-picker-input-hour", visible: false).set(time.hour)
        find(".bb-date-picker-input-min", visible: false).set(time.minute)
      end
    end
  end
end
