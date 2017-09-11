class BootstrapBuilders::Button
  attr_accessor :label

  def self.parse_url_args(args)
    args_parser = BootstrapBuilders::ArgumentsParser.new(
      arguments: args,
      short_true_arguments: [
        :block, :confirm, :danger, :disabled, :info, :link, :primary, :remote, :responsive, :warning, :lg, :md, :mini, :sm, :xs
      ]
    )
    args = args_parser.arguments

    is_an_active_record = BootstrapBuilders::IsAChecker.is_a?(args.first, "ActiveRecord::Base")
    is_a_baza_model = BootstrapBuilders::IsAChecker.is_a?(args.first, "BazaModels::Model")

    if args.first.is_a?(Array) || args.first.is_a?(String) || is_an_active_record || is_a_baza_model
      args_parser.arguments_hash[:url] ||= args.shift
    end

    args_parser.arguments_hash[:label] ||= args.shift if args.first.is_a?(String)
    args_parser.arguments_hash
  end

  def initialize(args)
    @args = args
    @label = args[:label]
    @class = args[:class]
    @url = args.fetch(:url)
    @args = args
    @context = args.fetch(:context)
    @icon = args[:icon]
    @can = args[:can]
    @mini = args[:mini]

    @data = args[:data] || {}
    @data[:bb_icon] = @icon.present?

    @args[:title] ||= @label if @args[:responsive] && @label.present?
  end

  def classes
    unless @classes
      @classes = BootstrapBuilders::ClassAttributeHandler.new(class: ["btn"])
      handle_mini_argument
      @classes.add(@class) if @class
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

  def html
    return unless can?

    handle_confirm_argument

    link_args = {
      class: classes.classes,
      data: @data,
      method: @args[:method],
      target: @args[:target],
      remote: @args[:remote],
      title: @args[:title]
    }

    link_args[:disabled] = true if @args[:disabled]

    @context.link_to(@url, link_args) do
      html = ""
      html << @context.content_tag(:i, nil, class: ["fa", "fa-#{@icon}"]) if @icon

      if @label && !@mini
        html << @context.content_tag(:span, " #{@label}", class: "bb-btn-label")
      end

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

  def add_default_as_default
    @classes.add("btn-default") if !@args[:danger] && !@args[:info] && !@args[:primary] && !@args[:warning]
  end

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

  def handle_confirm_argument
    return unless @args[:confirm]
    @data[:confirm] = I18n.t("are_you_sure")
  end

  def handle_mini_argument
    return unless @mini
    @classes.add(["bb-btn-mini", "btn-xs"])
  end
end
