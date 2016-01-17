class BootstrapBuilders::Box
  def initialize(args)
    @title = args.fetch(:title)
    @width = args.fetch(:width)
    @right = args[:right]
    @table = args[:table]
    @block = args.fetch(:block)

    @width = "#{@width}px" if @width.is_a?(Fixnum) || @width.is_a?(Integer)
  end

  def html
    @panel = HtmlGen::Element.new(:div, classes: ["panel", "panel-default"], css: {width: @width})

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
    title.add_ele(:div, classes: ["pull-right"], str_html: @right)
  end

  def add_table
    @panel.add_ele(:table, classes: ["table", "table-striped", "table-hover"], str_html: @block.call)
  end

  def add_body
    @panel.add_ele(:div, classes: ["panel-body"], str_html: @block.call)
  end
end
