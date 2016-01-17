module WorkingHelpers
  include BootstrapBuilders::ApplicationHelpers

  def t(key)
    key
  end

  def link_to(*opts)
    title = opts.shift if !opts.first.is_a?(Hash) && ((opts.length == 2 && !opts.last.is_a?(Hash)) || (opts.length == 3))
    url = opts.shift unless opts.first.is_a?(Hash)
    title ||= yield if block_given?

    attrs = opts.shift || {}
    attrs[:href] = url

    classes = attrs.delete(:class)

    HtmlGen::Element.new(:a, classes: classes, attr: attrs, str_html: title).html
  end

  def content_tag(*opts)
    tag_name = opts.shift

    content = opts.shift if opts.length >= 2
    content = yield if block_given?

    attrs = opts.shift

    classes = attrs.delete(:class)

    HtmlGen::Element.new(tag_name, classes: classes, attr: attrs, str_html: content).html
  end
end

class String
  def html_safe
    self
  end
end
