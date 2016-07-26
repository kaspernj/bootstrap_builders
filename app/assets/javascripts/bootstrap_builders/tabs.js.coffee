$ ->
  $("body").on "click", ".bb-tabs-container .nav li[data-ajax-url]", ->
    li = $(this)
    link = $("a", li)
    content_id = link.attr("href").substring(1, 999)
    content = $(".bb-tabs-container #" + content_id + " .bb-tab-container")

    return if li.data("ajax-loaded")
    li.data("ajax-loaded", true)

    content.fadeOut 0, ->
      $.get li.data("ajax-url"), (data) ->
        content.html(data)
        content.fadeIn "fast"
