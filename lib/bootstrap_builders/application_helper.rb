module BootstrapBuilders::ApplicationHelper
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

  def bs_edit_btn(*args)
    args = BootstrapBuilders::Button.parse_url_args(args)
    args[:label] = t("edit") unless args.key?(:label)

    button = BootstrapBuilders::Button.new(args.merge(icon: "wrench", context: self, can_type: :edit))
    button.classes.add(["bb-btn", "bb-btn-edit"])
    button.classes.add("bb-btn-edit-#{button.can_model_class.name.tableize.singularize}") if button.can_model_class
    button.classes.add("bb-btn-edit-#{button.can_model_class.name.tableize.singularize}-#{button.can_model.id}") if button.can_model
    button.html
  end

  def bs_destroy_btn(*args)
    args = BootstrapBuilders::Button.parse_url_args(args)
    args[:label] = t("delete") unless args.key?(:label)

    args[:data] ||= {}
    args[:data][:confirm] ||= t("are_you_sure")

    button = BootstrapBuilders::Button.new(args.merge(icon: "remove", context: self, can_type: :destroy, method: :delete))
    button.classes.add(["btn-danger", "bb-btn", "bb-btn-destroy"])
    button.classes.add("bb-btn-destroy-#{button.can_model_class.name.tableize.singularize}") if button.can_model_class
    button.classes.add("bb-btn-destroy-#{button.can_model_class.name.tableize.singularize}-#{button.can_model.id}") if button.can_model

    button.html
  end

  def bs_new_btn(*args)
    args = BootstrapBuilders::Button.parse_url_args(args)
    args[:label] = t("add_new") unless args.key?(:label)
    button = BootstrapBuilders::Button.new(args.merge(icon: "pencil", context: self, can_type: :new))

    button.classes.add(["bb-btn", "bb-btn-new"])
    button.classes.add("bb-btn-new-#{button.can_model_class.name.tableize.singularize}") if button.can_model_class

    button.html
  end

  def bs_show_btn(*args)
    args = BootstrapBuilders::Button.parse_url_args(args)
    args[:label] = t("show") unless args.key?(:label)
    button = BootstrapBuilders::Button.new(args.merge(icon: "zoom-in", context: self, can_type: :show))
    button.classes.add(["bb-btn", "bb-btn-show"])
    button.classes.add("bb-btn-show-#{button.can_model_class.name.tableize.singularize}") if button.can_model_class
    button.classes.add("bb-btn-show-#{button.can_model_class.name.tableize.singularize}-#{button.can_model.id}") if button.can_model
    button.html
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
