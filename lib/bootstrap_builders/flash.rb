class BootstrapBuilders::Flash
  def initialize(args)
    @class = args[:class]
    @alert_types = [:success, :info, :warning, :danger]
    @context = args.fetch(:context)
  end

  def html
    flash_messages = []
    @context.flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless @alert_types.include?(type)

      close_button = @context.content_tag(:button, @context.raw("&times;"), type: "button", class: "close", "data-dismiss" => "alert")

      Array(message).each do |msg|
        text = @context.content_tag(:div, close_button + msg, class: classes(type))
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

private

  def classes(type)
    classes = []

    if @class.is_a?(String)
      classes += @class.split(/\s+/)
    elsif @class.is_a?(Array)
      classes += @class
    end

    classes += ["bb-flash", "alert", "alert-#{type}"]
    classes
  end
end
