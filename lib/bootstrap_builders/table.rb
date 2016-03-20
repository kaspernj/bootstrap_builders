class BootstrapBuilders::Table
  def initialize(args)
    @args = args
    @blk = args.delete(:blk)
    @context = args.delete(:context)
  end

  def html
    @context.content_tag(:table, attributes, &@blk)
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

    if @args[:class].is_a?(String)
      classes += @args.fetch(:class).split(/\s+/)
    elsif @args[:class].is_a?(Array)
      classes += @args.fetch(:class)
    end

    classes += ["table", "bb-table"]
    classes
  end
end
