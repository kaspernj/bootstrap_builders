require "bootstrap_builders/engine"
require "simple_form"
require "bb_date_picker_input"
require "bb_date_time_picker_input"
require "html_gen"

module BootstrapBuilders
  extend ActiveSupport::Autoload

  autoload :AttributeRows
  autoload :ArgumentsParser
  autoload :Button
  autoload :ClassAttributeHandler
  autoload :Configuration
  autoload :Flash
  autoload :IsAChecker
  autoload :Panel
  autoload :ProgressBar
  autoload :Table
  autoload :Tab
  autoload :Tabs

  def self.configuration
    @configuration ||= BootstrapBuilders::Configuration.new
  end
end
