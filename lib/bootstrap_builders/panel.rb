class BootstrapBuilders::Panel
  def initialize(args)
    @title = args.fetch(:title)
    @controls = args[:controls]
    @table = args[:table]
    @block = args.fetch(:block)
    @context = args.fetch(:context)
    @class = args[:class]
    @data = args[:data]

    @css = {}
    @css[:width] = args.fetch(:width) if args[:width]
  end

  def html
    @panel = HtmlGen::Element.new(:div, inden: "  ", classes: container_classes, css: @css, data: @data)

    add_heading if @title || @controls

    if @table
      add_table
    else
      add_body
    end

    html = @panel.html

    if html.respond_to?(:html_safe)
      html.html_safe
    else
      html
    end
  end

private

  def add_heading
    heading = @panel.add_ele(:div, classes: ["panel-heading", "clearfix"])

    if !@title || @title.to_s.strip.empty?
      heading.add_ele(:div, classes: ["panel-title", "pull-left"], str_html: "&nbsp;") if @controls
    else
      heading.add_ele(:div, classes: ["panel-title", "pull-left"], str: @title)
    end

    heading.add_ele(:div, classes: ["pull-right"], str_html: controls_content) if @controls
  end

  def controls_content
    if @controls.is_a?(Array)
      @controls.join(" ")
    else
      @controls.to_s
    end
  end

  def add_table
    table_responsive = @panel.add_ele(:div, classes: ["table-responsive"])

    table_args = {
      class: "bb-panel-table",
      bs_classes: ["table-striped", "table-hover", "bb-panel-table"],
      context: @context,
      blk: @block
    }

    table_args.merge!(@table) if @table.is_a?(Hash)

    table = BootstrapBuilders::Table.new(table_args)
    table_responsive.add_html(table.html)
  end

  def add_body
    @panel.add_html(@context.content_tag(:div, nil, class: ["panel-body"], &@block))
  end

  def container_classes
    classes = ["panel", "panel-default", "bb-panel"]

    if @class.is_a?(String)
      classes += @class.split(/\s+/)
    elsif @class.is_a?(Array)
      classes += @class
    end

    classes
  end
end
