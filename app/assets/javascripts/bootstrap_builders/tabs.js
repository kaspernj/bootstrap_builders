function loadAjaxTab(li) {
  if (li.data("ajax-loaded"))
    return

  var link = $("a", li)
  var content_id = link.attr("href").substring(1, 999)
  var content = $(".bb-tabs-container #" + content_id + " .bb-tab-container")

  li.data("ajax-loaded", true)
  content.fadeOut(0, function() {
    $.get(li.data("ajax-url"), function(data) {
      content.html(data)
      content.show()
    })
  })
}

// Makes sure the correct tab is loaded on page load
function loadActiveAjaxTabOnPageLoad() {
  // Loads the dynamic content of a tab when activated and sets the URL to the tab ID
  $("body").on("click", ".bb-tabs-container .nav li", function() {
    var li = $(this)

    if (li.data("ignore-next-history-push")) {
      li.data("ignore-next-history-push", null)
    } else if(li.data("specific-id-given")) {
      var urlb = new UrlBuilder(window.location.href)
      urlb.queryParameters["bb_selected_tab"] = $(this).data("tab-container-id")
      window.history.pushState({active_tab: li.data("tab-container-id"), event: "bb-tab-change", turbolinks: {}}, null, urlb.pathWithQueryParameters())
    }

    if (li.data("ajax-url"))
      loadAjaxTab(li)
  })

  var activeTabLink = $(".bb-tabs-container .nav li[data-ajax-url] a.active")

  if (activeTabLink.length > 0)
    loadAjaxTab(activeTabLink.parent())
}

$(document).ready(function() {
  loadActiveAjaxTabOnPageLoad()

  // Changes the tab on 'back' and 'forward' events
  $(window).bind("popstate", function(e) {
    if (e.originalEvent.state && e.originalEvent.state.event == "bb-tab-change") {
      var selected_tab = e.originalEvent.state.active_tab
    } else {
      var urlb = new UrlBuilder(window.location.href)
      var selected_tab = urlb.queryParameters["bb_selected_tab"]
    }

    if (!selected_tab)
      selected_tab = $($(".bb-tabs-container .nav li").first()).data("tab-container-id")

    var li = null
    var link = null
    if (selected_tab) {
      li = $("li[data-tab-container-id='" + selected_tab + "']")
      link = $("a", li)
    }

    if (link && link.length > 0 && !link.hasClass("active")) {
      li.data("ignore-next-history-push", true)
      link.click()
    }
  })
})

document.addEventListener("turbolinks:load", function() {
  loadActiveAjaxTabOnPageLoad()
})
