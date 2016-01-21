module ApplicationHelpers
  def bs_box(*opts, &blk)
    title = opts.shift unless opts.first.is_a?(Hash)
    width = opts.shift unless opts.first.is_a?(Hash)

    if opts.length == 1 && opts.first.is_a?(Hash)
      args = opts.first
      title = args.fetch(:title) if args.key?(:title)
      width = args[:width] if args.key?(:width)
      right = args[:right] if args.key?(:right)
    else
      args = {}
    end

    BootstrapBuilders::Box.new(args.merge(title: title, width: width, right: right, block: blk, context: self)).html
  end

  def bs_edit_button(args)
    BootstrapBuilders::Button.new(args.merge(title: t("edit"), icon: "wrench", context: self, can_type: :edit)).html
  end

  def bs_destroy_button(args)
    args[:data] ||= {}
    args[:data][:confirm] ||= t("are_you_sure")

    button = BootstrapBuilders::Button.new(args.merge(title: t("delete"), icon: "remove", context: self, can_type: :destroy, method: :delete))
    button.classes << "btn-danger"
    button.html
  end

  def bs_new_button(args)
    BootstrapBuilders::Button.new(args.merge(title: t("add_new"), icon: "pencil", context: self, can_type: :new)).html
  end

  def bs_show_button(args)
    BootstrapBuilders::Button.new(args.merge(title: t("show"), icon: "zoom-in", context: self, can_type: :show)).html
  end

  def bs_table(args = {}, &blk)
    classes = ["table", "table-bordered", "table-striped", "table-hover"]

    if args[:class].is_a?(String)
      classes += args.fetch(:class).split(/\s+/)
    elsif args[:class].is_a?(Array)
      classes += args.fetch(:class)
    end

    content_tag(:table, class: classes, &blk)
  end
end
