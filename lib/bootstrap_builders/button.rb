class BootstrapBuilders::Button
  def initialize(args)
    @title = args.fetch(:title)
    @mini = args[:mini]
    @class = args[:class]
    @url = args.fetch(:url)
    @args = args
    @context = args.fetch(:context)
    @icon = args.fetch(:icon)
  end

  def classes
    unless @classes
      @classes = ["btn", "btn-default"]
      @classes << "btn-xs" if @mini

      if @class.is_a?(String)
        @classes += @class.split(/\s+/)
      elsif @class.is_a?(Array)
        @classes += @class
      end
    end

    @classes
  end

  def html
    @context.link_to @url, class: classes, data: @args[:data], method: @args[:method], remote: @args[:remote] do
      html = ""
      html << @context.content_tag(:i, nil, class: ["fa", "fa-#{@icon}"])
      html << " #{@title}"
      html.html_safe
    end
  end

private

  def model_from_url(url)
    if url.is_a?(Array) && url.last.is_a?(ActiveRecord::Base)
      url.last
    elsif url.is_a?(ActiveRecord::Base)
      url
    else
      return nil
    end
  end
end
