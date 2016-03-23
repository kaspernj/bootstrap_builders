class BootstrapBuilders::Flash
  def initialize(args)
    @class = args[:class]
    @alert_types = [:success, :info, :warning, :danger]
    @context = args[:context]
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

      tag_class = @class
      tag_options = {
        class: "bb-flash alert fade in alert-#{type} #{tag_class}"
      }

      close_button = @context.content_tag(:button, @context.raw("&times;"), type: "button", class: "close", "data-dismiss" => "alert")

      Array(message).each do |msg|
        text = @context.content_tag(:div, close_button + msg, tag_options)
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
end
