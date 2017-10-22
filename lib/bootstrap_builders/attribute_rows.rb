class BootstrapBuilders::AttributeRows
  def initialize(args)
    @model = args.fetch(:model)
    @attributes = args.fetch(:attributes)
    @context = args.fetch(:context)
  end

  def html
    elements = []

    @attributes.each do |attribute|
      tr = HtmlGen::Element.new(:tr, classes: ["bb-attributes-row", "bb-attributes-row-#{attribute}"])
      tr.add_ele(:th, classes: ["bb-attributes-row-title"], str: @model.class.human_attribute_name(attribute))

      if column_type(attribute) == :boolean
        str = @model.__send__("#{attribute}?") ? @context.t("yes") : @context.t("no")
      elsif column_type(attribute) == :model
        model_value = column_value(attribute)

        unless model_value.nil?
          link_method_name = "link_to_#{StringCases.camel_to_snake(model_value.class.name)}"

          if @view.respond_to?(:link_to_model)
            str = @view.link_to_model(model_value)
          elsif @context.respond_to?(link_method_name)
            str_html = @context.__send__(link_method_name, model_value)
          else
            str = model_value.name
          end
        end
      elsif column_type(attribute) == :datetime || column_type(attribute) == :date
        str = @context.l(column_value(attribute), format: :long) if column_value(attribute)
      elsif column_type(attribute) == :money
        str = column_value(attribute).try(:format)
      else
        str = column_value(attribute).to_s
      end

      if str
        tr.add_ele(:td, classes: ["bb-attributes-row-value"], str: str)
      else
        tr.add_ele(:td, classes: ["bb-attributes-row-value"], str_html: str_html)
      end

      elements << tr.html
    end

    html = elements.join("\n")
    html = html.html_safe if html.respond_to?(:html_safe)
    html
  end

private

  def column_type(column)
    return :state if column == :state && @model.class.respond_to?(:state_machine)

    type = @model.class.columns_hash[column.to_s].try(:type)
    return type if type

    reflection = @model.class.reflections[column]
    return :model if reflection && reflection.is_a?(ActiveRecord::Reflection::AssociationReflection)

    return :money if @model.class.respond_to?(:monetized_attributes) && @model.class.monetized_attributes.key?(column)

    value = column_value(column)
    return :model if value.is_a?(ActiveRecord::Base)

    reflection_association = @model.class.reflect_on_association(column)
    return :model if reflection_association

    return :method if @model.respond_to?(column)

    raise "Couldn't find out type for column '#{column}' on class '#{@model.class.name}'."
  end

  def column_value(column)
    translated_column_method = "#{column}_translated"
    translated_column_method_end = "translated_#{column}"
    translated_option_helper_method = "#{@model.class.name.underscore}_translated_#{column}"
    translated_state_method_name = "#{@model.class.name.underscore}_translated_state"

    if column == :state && @model.class.respond_to?(:state_machine) && @view.respond_to?(translated_state_method_name)
      return @view.__send__(translated_state_method_name, @model)
    elsif @view.respond_to?(translated_option_helper_method)
      return @view.__send__(translated_option_helper_method, @model)
    elsif @model.respond_to?(translated_column_method)
      return @model.__send__(translated_column_method)
    elsif @model.respond_to?(translated_column_method_end)
      return @model.__send__(translated_column_method_end)
    end

    @model.__send__(column)
  end
end
