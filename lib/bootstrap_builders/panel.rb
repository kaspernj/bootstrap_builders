class BootstrapBuilders::Panel
  attr_accessor :context, :controls

  def self.with_parsed_args(*args_given, &blk)
    args_parser = BootstrapBuilders::ArgumentsParser.new(
      arguments: args_given,
      short_true_arguments: [
        :collapsable, :collapsed, :table
      ]
    )
    args = args_parser.arguments
    args_hash = args_parser.arguments_hash

    title = args.shift if args.first.is_a?(String)
    width = args.shift unless args.first.is_a?(Hash)

    title = args_hash.fetch(:title) if args_hash.key?(:title)
    width = args_hash[:width] if args_hash.key?(:width)
    right = args_hash[:right] if args_hash.key?(:right)

    BootstrapBuilders::Panel.new(args_hash.merge(title: title, width: width, right: right, block: blk))
  end

  def initialize(args)
    @collapsable = args[:collapsable]
    @collapsed = args[:collapsed]
    @title = args.fetch(:title)
    @table = args[:table]
    @context = args[:context]
    @class = args[:class]
    @data = args[:data]

    @controls = args[:controls]
    @controls = [@controls] unless @controls.is_a?(Array)

    @css = {}
    @css[:width] = args.fetch(:width) if args[:width]

    @block = proc do
      args.fetch(:block).call(self)
    end
  end

  def html
    @panel = HtmlGen::Element.new(:div, inden: "  ", classes: container_classes, css: @css, data: @data)

    generate_body
    add_heading if heading?
    add_body
    add_heading_controls
    html = @panel.html

    if html.respond_to?(:html_safe)
      html.html_safe # rubocop:disable Rails/OutputSafety
    else
      html
    end
  end

private

  def add_heading
    @heading = @panel.add_ele(:div, classes: ["card-header", "clearfix"])

    if !@title || @title.to_s.strip.empty?
      @heading.add_ele(:h4, classes: ["pull-left"], str_html: "&nbsp;") if controls?
    else
      panel_title = @heading.add_ele(:div, classes: ["pull-left"])

      if @collapsable
        panel_title.add_ele(:a, attr: {href: "##{collapse_id}"}, data: {toggle: "collapse"}, str: @title)
      else
        panel_title.add_html_if_safe(@title)
      end
    end
  end

  def add_heading_controls
    @heading.add_ele(:div, classes: ["pull-right"], str_html: controls_content) if controls?
  end

  def controls?
    @controls && @controls.any?
  end

  def controls_content
    if @controls.is_a?(Array)
      @controls.join(" ")
    else
      @controls.to_s
    end
  end

  def heading?
    @title.present? || controls?
  end

  def table?
    @table.present?
  end

  def add_body
    if @collapsable
      classes = ["panel-collapse", "collapse"]
      classes << "in" unless @collapsed

      collapse = @panel.add_ele(:div, classes: classes, attr: {id: collapse_id})
      collapse.add_html(@generated_body)
    else
      @panel.add_html(@generated_body)
    end
  end

  def collapse_id
    @collapse_id ||= "bb-collapse-#{SecureRandom.hex(4)}"
  end

  def container_classes
    classes = ["card", "bb-panel"]

    if @class.is_a?(String)
      classes += @class.split(/\s+/)
    elsif @class.is_a?(Array)
      classes += @class
    end

    classes
  end

  def generate_body
    if table?
      generate_body_table
    else
      @generated_body = @context.content_tag(:div, nil, class: "card-body", &@block)
    end
  end

  def generate_body_table
    bs_classes = BootstrapBuilders.configuration.default_table_classes - [:bordered]

    table_args = {
      class: "bb-panel-table",
      bs_classes: bs_classes,
      context: @context,
      blk: @block,
      responsive: true
    }

    table_args.merge!(@table) if @table.is_a?(Hash)
    @generated_body = BootstrapBuilders::Table.new(table_args).html
  end
end
