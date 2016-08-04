$ ->
  loadAjaxTab = (li) ->
    link = $("a", li)
    content_id = link.attr("href").substring(1, 999)
    content = $(".bb-tabs-container #" + content_id + " .bb-tab-container")

    li.data("ajax-loaded", true)
    content.fadeOut 0, ->
      $.get li.data("ajax-url"), (data) ->
        content.html(data)
        content.fadeIn "fast"

  $("body").on "click", ".bb-tabs-container .nav li", ->
    li = $(this)

    if li.data("specific-id-given")
      urlb = new UrlBuilder(window.location.href)
      urlb.queryParameters["bb_selected_tab"] = $(this).data("tab-container-id")

      window.history.pushState("bb-tab-change", "", urlb.pathWithQueryParameters())

    if li.data("ajax-url") && !li.data("ajax-loaded")
      loadAjaxTab(li)

  active_tab = $(".bb-tabs-container .nav li.active[data-ajax-url]")
  loadAjaxTab(active_tab) if active_tab.length > 0
