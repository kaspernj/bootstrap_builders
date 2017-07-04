class BootstrapBuilders::Tabs
  def initialize(args)
    @args = args
    @context = args.fetch(:context)
    @tabs = []
  end

  def tab(*args, &blk)
    tab_args = {}

    tab_args[:label] = args.shift if args.first.is_a?(String)
    tab_args[:container_id] = args.shift if args.first.is_a?(String)
    tab_args.merge!(args.shift) if args.first.is_a?(Hash)

    tab = BootstrapBuilders::Tab.new(tab_args)
    tab.container_html = @context.content_tag(:div, nil, class: ["bb-tab-container"], &blk)
    @tabs << tab
    nil
  end

  def to_html
    set_default_first_active

    container = HtmlGen::Element.new(:div, classes: ["bb-tabs-container"])
    ul = container.add_ele(:ul, classes: nav_classes)
    container.add_ele(:div, classes: ["clearfix"])

    @tabs.each do |tab|
      li = ul.add_ele(:li, data: {specific_id_given: tab.specific_id_given?, tab_container_id: tab.container_id})
      li.add_ele(:a, str: tab.label, attr: {href: "##{tab.container_id}"}, data: {toggle: "tab"})
      li.classes << "active" if tab.active?
      li.data[:ajax_url] = tab.ajax_url if tab.ajax_url.present?
    end

    tabs_content = container.add_ele(:div, classes: ["tab-content"])

    @tabs.each do |tab|
      tab_content = tabs_content.add_ele(:div, classes: ["tab-pane"], attr: {id: tab.container_id})
      tab_content.add_html(tab.container_html)
      tab_content.classes << "active" if tab.active?
    end

    container.html
  end

private

  def nav_classes
    classes = ["nav"]
    classes << "nav-stacked" if @args[:stacked]
    classes << "nav-justified" if @args[:justified]

    if @args[:pills]
      classes << "nav-pills"
    else
      classes << "nav-tabs"
    end

    classes
  end

  def set_default_first_active
    return if @tabs.any?(&:active?)

    active_found = false

    if @context.params["bb_selected_tab"].present?
      tab = @tabs.find { |tab_i| tab_i.container_id == @context.params["bb_selected_tab"] }

      if tab
        tab.active = true
        active_found = true
      end
    end

    @tabs.first.active = true if @tabs.any? && !active_found
  end
end
