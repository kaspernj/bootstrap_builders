class BootstrapBuilders::Table
  def initialize(args)
    @args = args
    @blk = args.fetch(:blk)
    @context = args.fetch(:context)
  end

  def html
    if @blk
      buffer = @context.content_tag(:table, attributes, &@blk)
    else
      buffer = @context.content_tag(:table, @content, attributes)
    end

    return buffer unless @args[:responsive]

    @context.content_tag(:div, buffer, class: "table-responsive")
  end

private

  def attributes
    attributes = {class: classes}

    pass_through = [:data]
    pass_through.each do |pass_through_arg|
      next unless @args.key?(pass_through_arg)
      attributes[pass_through_arg] = @args[pass_through_arg]
    end

    attributes
  end

  def classes
    if @args[:bs_classes]
      classes = @args[:bs_classes]
    else
      classes = BootstrapBuilders.configuration.default_table_classes
    end

    classes = classes.map { |class_name| "table-#{class_name}" }

    if @args[:class].is_a?(String)
      classes += @args.fetch(:class).split(/\s+/)
    elsif @args[:class].is_a?(Array)
      classes += @args.fetch(:class)
    end

    classes += ["table", "bb-table"]
    classes
  end
end
