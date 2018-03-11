function loadAjaxTab(li) {
  var link = $("a", li)
  var content_id = link.attr("href").substring(1, 999)
  var content = $(".bb-tabs-container #" + content_id + " .bb-tab-container")

  li.data("ajax-loaded", true)
  content.fadeOut(0, function() {
    $.get(li.data("ajax-url"), function(data) {
      content.html(data)
      content.fadeIn("fast")
    })
  })
}

// Makes sure the correct tab is loaded on page load
function loadActiveAjaxTabOnPageLoad() {
  //Loads the dynamic content of a tab when activated and sets the URL to the tab ID
  $("body").on("click", ".bb-tabs-container .nav li", function() {
    var li = $(this)

    if (li.data("ignore-next-history-push")) {
      li.data("ignore-next-history-push", null)
    } else if(li.data("specific-id-given")) {
      var urlb = new UrlBuilder(window.location.href)
      urlb.queryParameters["bb_selected_tab"] = $(this).data("tab-container-id")
      window.history.pushState({active_tab: li.data("tab-container-id"), event: "bb-tab-change"}, null, urlb.pathWithQueryParameters())
    }

    if (li.data("ajax-url") && !li.data("ajax-loaded")) {
      loadAjaxTab(li)
    }
  })

  var active_tab = $(".bb-tabs-container .nav li.active[data-ajax-url]")

  if (active_tab.length > 0) {
    loadAjaxTab(active_tab)
  }
}

$(document).ready(function() {
  // Changes the tab on 'back' and 'forward' events
  $(window).bind("popstate", function(e) {
    if (e.originalEvent.state && e.originalEvent.state.event == "bb-tab-change") {
      var selected_tab = e.originalEvent.state.active_tab
    } else {
      var urlb = new UrlBuilder(window.location.href)
      var selected_tab = urlb.queryParameters["bb_selected_tab"]
    }

    if (!selected_tab) {
      selected_tab = $($(".bb-tabs-container .nav li").first()).data("tab-container-id")
    }

    var li = null
    if (selected_tab) {
      li = $("li[data-tab-container-id='" + selected_tab + "']")
    }

    if (li && !li.hasClass("active")) {
      console.log("Click on LI")
      li.data("ignore-next-history-push", true)
      $("a", li).click()
    }
  })
})

document.addEventListener("turbolinks:load", function() {
  loadActiveAjaxTabOnPageLoad()
})
