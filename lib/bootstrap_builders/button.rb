class BootstrapBuilders::Button
  attr_accessor :label

  def self.parse_url_args(args)
    if args.last.is_a?(Hash)
      real_args = args.pop
    else
      real_args = {}
    end

    real_args[:url] ||= args.shift if args.first
    real_args[:label] ||= args.shift if args.first
    real_args
  end

  def initialize(args)
    @label = args[:label]
    @class = args[:class]
    @url = args.fetch(:url)
    @args = args
    @context = args.fetch(:context)
    @icon = args[:icon]
    @can = args[:can]
    @small = args[:small]
    @mini = args[:mini]
  end

  def classes
    unless @classes
      @classes = BootstrapBuilders::ClassAttributeHandler.new(class: ["btn", "btn-default"])
      @classes.add("btn-xs") if @mini || @small
      @classes.add(@class) if @class
    end

    @classes
  end

  def html
    return unless can?

    @context.link_to(@url, class: classes.classes, data: @args[:data], method: @args[:method], remote: @args[:remote]) do
      html = ""
      html << @context.content_tag(:i, nil, class: ["fa", "fa-#{@icon}"]) if @icon
      html << " #{@label}" if @label && !@mini
      html.strip.html_safe
    end
  end

  def can_model
    can_object unless @can_model
    @can_model
  end

  def can_model_class
    can_object unless @can_model_class
    @can_model_class
  end

private

  def can?
    authorize_object = can_object
    return true if !authorize_object || !@args[:can_type]
    @context.can? @args.fetch(:can_type), authorize_object
  end

  def can_object
    if !@can_object && @can_object != false
      if @can
        can_object_from_given_can_argument
      elsif @url
        can_object_from_url
      end

      @can_object = false unless @can_object
    end

    @can_object
  end

  def can_object_from_url
    url = @url.clone

    if url.is_a?(Array)
      url.pop if url.last.is_a?(Hash)
      last_element_in_url = url.last
    else
      last_element_in_url = url
    end

    if last_element_in_url.is_a?(Class)
      model_class = last_element_in_url
    else
      model_class = last_element_in_url.class
    end

    ancestors = model_class.ancestors.map(&:name)

    if ancestors.include?("ActiveRecord::Base") || ancestors.include?("BazaModels::Model")
      @can_object = last_element_in_url
      @can_model = last_element_in_url unless last_element_in_url.is_a?(Class)
      @can_model_class = model_class
    end
  end

  def can_object_from_given_can_argument
    if @can.is_a?(Class)
      model_class = @can
    else
      model_class = @can.class
    end

    ancestors = model_class.ancestors.map(&:name)

    if ancestors.include?("ActiveRecord::Base") || ancestors.include?("BazaModels::Model")
      @can_object = @can
      @can_model = @can unless @can.is_a?(Class)
      @can_model_class = model_class
    end
  end
end
