class BootstrapBuilders::ButtonDropDown
  attr_accessor :view_context

  def initialize(*args)
    args_parser = BootstrapBuilders::ArgumentsParser.new(
      arguments: args,
      short_true_arguments: [:block, :danger, :link, :info, :primary, :sm, :warning, :xs]
    )

    args_parser.arguments_hash[:label] ||= args.shift if args.first.is_a?(String)
    @args = args_parser.arguments_hash
    @buttons = []
  end

  def option(*args)
    args_parser = BootstrapBuilders::ArgumentsParser.new(
      arguments: args,
      short_true_arguments: [:confirm]
    )

    args = args_parser.arguments

    if args.first.is_a?(Array) || args.first.is_a?(String) || is_an_active_record || is_a_baza_model
      args_parser.arguments_hash[:url] ||= args.shift
    end

    args_parser.arguments_hash[:label] ||= args.shift if args.first.is_a?(String)

    @buttons << args_parser.arguments_hash
  end

  def html
    btn_group = HtmlGen::Element.new(:div, classes: ["btn-group"])
    main_button = btn_group.add_ele(
      :button,
      attr: {
        "aria-haspopup" => true,
        "aria-exapended" => false,
        type: "button"
      },
      classes: classes.classes,
      data: {
        toggle: "dropdown"
      }
    )
    main_button.add_ele(:i, classes: ["fa", "fa-fw", "fa-#{@args.fetch(:icon)}"]) if @args[:icon].present?
    main_button.add_str(@args.fetch(:label)) if @args[:label].present?
    main_button.add_ele(:span, classes: ["caret"]) if !@args.key?(:caret) || @args[:cart]

    ul = btn_group.add_ele(:ul, classes: ["dropdown-menu"])

    @buttons.each do |button|
      li = ul.add_ele(:li)

      link_args = {class: BootstrapBuilders::ClassAttributeHandler.short(button[:class])}
      link_args.deep_merge!(data: {confirm: I18n.t("are_you_sure")}) if button[:confirm]
      link_args.deep_merge!(data: {method: button[:method]}) if button[:method].present?
      link_args.deep_merge!(data: button[:data]) if button[:data]

      link = view_context.link_to(button.fetch(:url), link_args) do
        if button[:icon]
          view_context.safe_join [view_context.content_tag(:i, nil, class: ["fa", "fa-fw", "fa-#{button.fetch(:icon)}"]), " ", button.fetch(:label)]
        else
          button.fetch(:label)
        end
      end

      li.add_html(link)
    end

    btn_group.html
  end

private

  def add_default_as_default
    @classes.add("btn-default") if !@args[:danger] && !@args[:info] && !@args[:primary] && !@args[:warning]
  end

  def classes
    unless @classes
      @classes = BootstrapBuilders::ClassAttributeHandler.new(class: ["btn", "btn-default", "dropdown-toggle"])
      @classes.add("bb-btn-responsive") if @args[:responsive]
      add_default_as_default
      @classes.add("btn-block") if @args[:block]
      @classes.add("btn-danger") if @args[:danger]
      @classes.add("btn-info") if @args[:info]
      @classes.add("btn-link") if @args[:link]
      @classes.add("btn-primary") if @args[:primary]
      @classes.add("btn-warning") if @args[:warning]

      size_classes = [:lg, :md, :sm, :xs]
      size_classes.each do |size_class|
        next unless @args[size_class]
        btn_size_class = "btn-#{size_class}"
        @classes.add(btn_size_class) unless @classes.include?(btn_size_class)
      end
    end

    @classes
  end
end
