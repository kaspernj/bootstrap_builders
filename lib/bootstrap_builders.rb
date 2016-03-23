require "bootstrap_builders/engine"
require "html_gen"

module BootstrapBuilders
  extend ActiveSupport::Autoload

  autoload :AttributeRows
  autoload :Button
  autoload :ClassAttributeHandler
  autoload :Configuration
  autoload :IsAChecker
  autoload :Panel
  autoload :Table
  autoload :Flash

  def self.configuration
    @configuration ||= BootstrapBuilders::Configuration.new
  end
end
