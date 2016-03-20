require "bootstrap_builders/engine"
require "haml"
require "html_gen"

module BootstrapBuilders
  extend ActiveSupport::Autoload

  autoload :AttributeRows
  autoload :ClassAttributeHandler
  autoload :IsAChecker
  autoload :Panel
  autoload :Button
end
