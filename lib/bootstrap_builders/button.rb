class BootstrapBuilders::Button
  def initialize(args)
    @label = args.fetch(:label)
    @mini = args[:mini]
    @class = args[:class]
    @url = args.fetch(:url)
    @args = args
    @context = args.fetch(:context)
    @icon = args.fetch(:icon)
    @can = args[:can]
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

  def can?
    authorize_object = can_object
    return true if !authorize_object || !@args[:can_type]
    @context.can? @args.fetch(:can_type), authorize_object
  end

  def can_object
    return @can if @can

    if @url.is_a?(Array)
      model = @url.last
    else
      model = @url
    end

    return nil unless model

    ancestors = model.class.ancestors.map(&:name)
    return model if ancestors.include?("ActiveRecord::Base") || ancestors.include?("BazaModels::Model")
  end
end
