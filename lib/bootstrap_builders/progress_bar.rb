class BootstrapBuilders::ProgressBar
  def self.with_parsed_args(*opts)
    percent = opts.shift if opts.first.is_a?(Integer) || opts.first.is_a?(Float) || opts.first.is_a?(Fixnum)

    args_parser = BootstrapBuilders::ArgumentsParser.new(
      arguments: opts,
      short_true_arguments: []
    )

    BootstrapBuilders::ProgressBar.new({percent: percent}.merge(args_parser.arguments_hash)).html
  end

  def initialize(args)
    @percent = args.fetch(:percent)
  end

  def html
    progress = HtmlGen::Element.new(:div, classes: ["bb-progress-bar", "progress"])

    progress.add_ele(
      :div,
      classes: ["progress-bar"],
      attr: {
        "aria-valuenow" => @percent.to_i,
        "aria-valuemin" => 0,
        "aria-valuemax" => 100,
        role: "progressbar",
        style: "width: #{@percent}%;"
      }
    )

    progress.add_ele(:div, classes: ["bb-progress-bar-label"], str: "#{@percent.to_i}%")
    progress.html
  end
end
