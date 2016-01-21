class BootstrapBuilders::Button
  def initialize(args)
    @label = args.fetch(:label)
    @mini = args[:mini]
    @class = args[:class]
    @url = args.fetch(:url)
    @args = args
    @context = args.fetch(:context)
    @icon = args.fetch(:icon)
    can = args[:can]
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
    return unless can?

    @context.link_to @url, class: classes, data: @args[:data], method: @args[:method], remote: @args[:remote] do
      html = ""
      html << @context.content_tag(:i, nil, class: ["fa", "fa-#{@icon}"])
      html << " #{@label}" if @label
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

  def can?
    return true if !can_object || !@args[:can_type]
    @context.can? @args.fetch(:can_type), can_object
  end

  def can_object
    if @args[:can]
      @args[:can]
    elsif @args[:url].is_a?(Array) && @args[:url].last.is_a?(ActiveRecord::Base)
      @args[:url].last
    end
  end
end
