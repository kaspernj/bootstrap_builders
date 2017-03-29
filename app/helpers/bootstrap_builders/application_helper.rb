module BootstrapBuilders::ApplicationHelper
  include BootstrapBuilders::ButtonsHelper

  def bb_attribute_row(title, value)
    content_tag :tr do
      parts = []
      parts << content_tag(:th, title)
      parts << content_tag(:td, value)
      safe_join parts
    end
  end

  def bb_attribute_rows(model, attributes)
    BootstrapBuilders::AttributeRows.new(model: model, attributes: attributes, context: self).html
  end

  def bb_panel(*opts, &blk)
    panel = BootstrapBuilders::Panel.with_parsed_args(*opts, &blk)
    panel.context = self
    panel.html
  end

  def bb_progress_bar(*opts)
    BootstrapBuilders::ProgressBar.with_parsed_args(*opts)
  end

  def bb_flash(args = {})
    flash = BootstrapBuilders::Flash.new(args.merge(context: self))
    flash.html
  end

  def bb_table(args = {}, &blk)
    table = BootstrapBuilders::Table.new(args.merge(context: self, blk: blk))
    table.html
  end

  def bb_tabs(*args)
    args = BootstrapBuilders::ArgumentsParser.new(
      arguments: args,
      argument_hash_default: {context: self},
      short_true_arguments: [:justified, :pills, :stacked]
    ).arguments

    tabs = BootstrapBuilders::Tabs.new(*args)
    yield tabs
    tabs.to_html
  end
end
