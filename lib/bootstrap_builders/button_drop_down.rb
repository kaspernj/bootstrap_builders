class BootstrapBuilders::ButtonDropDown
  attr_accessor :view_context

  def initialize(args)
    @args = args
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
      classes: ["btn", "btn-default", "dropdown-toggle"],
      data: {
        toggle: "dropdown"
      }
    )
    main_button.add_str(@args.fetch(:label))
    main_button.add_ele(:span, classes: ["caret"])

    ul = btn_group.add_ele(:ul, classes: ["dropdown-menu"])

    @buttons.each do |button|
      li = ul.add_ele(:li)

      url = button.fetch(:url)
      url = view_context.polymorphic_url(url) if url.is_a?(Array)

      a_href = li.add_ele(:a, attr: {href: url}, classes: BootstrapBuilders::ClassAttributeHandler.short(button[:class]))

      a_href.data[:confirm] = I18n.t("are_you_sure") if button[:confirm]
      a_href.data[:method] = button[:method]
      a_href.data.merge!(button[:data]) if button[:data]

      if button[:icon]
        a_href.add_ele(:i, classes: ["fa", "fa-fw", "fa-#{button.fetch(:icon)}"])
      end

      a_href.add_str(button.fetch(:label))
    end

    btn_group.html
  end
end
