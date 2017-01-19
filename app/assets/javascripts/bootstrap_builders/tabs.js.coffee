$ ->
  # Used to load dynamic content of a tab
  loadAjaxTab = (li) ->
    link = $("a", li)
    content_id = link.attr("href").substring(1, 999)
    content = $(".bb-tabs-container #" + content_id + " .bb-tab-container")

    li.data("ajax-loaded", true)
    content.fadeOut 0, ->
      $.get li.data("ajax-url"), (data) ->
        content.html(data)
        content.fadeIn "fast"

  # Loads the dynamic content of a tab when activated and sets the URL to the tab ID
  $("body").on "click", ".bb-tabs-container .nav li", ->
    li = $(this)

    if li.data("ignore-next-history-push")
      li.data("ignore-next-history-push", null)
    else if li.data("specific-id-given")
      urlb = new UrlBuilder(window.location.href)
      urlb.queryParameters["bb_selected_tab"] = $(this).data("tab-container-id")

      window.history.pushState("bb-tab-change", "", urlb.pathWithQueryParameters())

    if li.data("ajax-url") && !li.data("ajax-loaded")
      loadAjaxTab(li)

  # Changes the tab on 'back' and 'forward' events
  $(window).bind "popstate", ->
    urlb = new UrlBuilder(window.location.href)
    selected_tab = urlb.queryParameters["bb_selected_tab"]

    li = $("li[data-tab-container-id='" + selected_tab + "']")

    unless li.hasClass("active")
      console.log("Click on LI")
      li.data("ignore-next-history-push", true)
      $("a", li).click()

  # Makes sure the correct tab is loaded on page load
  active_tab = $(".bb-tabs-container .nav li.active[data-ajax-url]")
  loadAjaxTab(active_tab) if active_tab.length > 0
