require "bootstrap_builders/engine"
require "html_gen"

autoload :BbDatePickerInput, "#{File.dirname(__FILE__)}/bb_date_picker_input"
autoload :BbDateTimePickerInput, "#{File.dirname(__FILE__)}/bb_date_time_picker_input"

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
