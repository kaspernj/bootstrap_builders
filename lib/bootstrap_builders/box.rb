class BootstrapBuilders::Box
  def initialize(args)
    @title = args.fetch(:title)
    @width = args.fetch(:width)
    @right = args[:right]
    @table = args[:table]
    @block = args.fetch(:block)
    @context = args.fetch(:context)

    if @width.is_a?(Fixnum) || @width.is_a?(Integer)
      @width = "#{@width}px"
    else
      @width = "100%"
    end
  end

  def html
    @panel = HtmlGen::Element.new(:div, inden: "  ", classes: ["panel", "panel-default"], css: {width: @width})

    add_heading if @title || @right

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
    title = heading.add_ele(:div, classes: ["panel-title", "pull-left"], str: @title)
    heading.add_ele(:div, classes: ["pull-right"], str_html: @right.to_s) if @right
  end

  def add_table
    @panel.add_html(@context.content_tag(:table, nil, class: ["table", "table-striped", "table-hover"], &@block))
  end

  def add_body
    @panel.add_html(@context.content_tag(:div, nil, class: ["panel-body"], &@block))
  end
end
