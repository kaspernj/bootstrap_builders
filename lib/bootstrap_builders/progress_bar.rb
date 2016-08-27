class BootstrapBuilders::ProgressBar
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
