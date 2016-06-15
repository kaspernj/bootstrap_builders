$ ->
  $.bbUpdateResponseButtons = ->
    view_port = $.bbViewPort()

    if $.bbViewPortOrBelow("md")
      $(".bb-btn-responsive .bb-btn-label").hide()
    else
      $(".bb-btn-responsive .bb-btn-label").show()

    if $.bbViewPortOrBelow("sm")
      $(".bb-btn-responsive").addClass("btn-xs")
    else
      $(".bb-btn-responsive").removeClass("btn-xs")

  $.bbViewPortChange -> $.bbUpdateResponseButtons()
  $.bbUpdateResponseButtons()
