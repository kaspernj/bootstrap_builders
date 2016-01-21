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
    args[:label] = t("edit") unless args.key?(:label)
    BootstrapBuilders::Button.new(args.merge(icon: "wrench", context: self, can_type: :edit)).html
  end

  def bs_destroy_button(args)
    args[:label] = t("delete") unless args.key?(:label)

    args[:data] ||= {}
    args[:data][:confirm] ||= t("are_you_sure")

    button = BootstrapBuilders::Button.new(args.merge(icon: "remove", context: self, can_type: :destroy, method: :delete))
    button.classes << "btn-danger"
    button.html
  end

  def bs_new_button(args)
    args[:label] = t("add_new") unless args.key?(:label)
    BootstrapBuilders::Button.new(args.merge(icon: "pencil", context: self, can_type: :new)).html
  end

  def bs_show_button(args)
    args[:label] = t("show") unless args.key?(:label)
    BootstrapBuilders::Button.new(args.merge(icon: "zoom-in", context: self, can_type: :show)).html
  end

  def bs_table(&blk)
    content_for(:table, class: ["table", "table-striped", "table-hover"], &blk)
  end
end
