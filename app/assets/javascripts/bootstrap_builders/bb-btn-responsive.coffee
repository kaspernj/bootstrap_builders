$ ->
  $.bbUpdateResponseButtons = ->
    if $.bbViewPortOrBelow("md")
      $(".bb-btn-responsive").addClass("btn-xs")
    else
      $(".bb-btn-responsive").removeClass("btn-xs")

  $.bbViewPortChange -> $.bbUpdateResponseButtons()
  $.bbUpdateResponseButtons()
