require "html_gen"

class BootstrapBuilders
  path = "#{File.dirname(__FILE__)}/bootstrap_builders"

  autoload :ApplicationHelper, "#{path}/application_helper"
  autoload :ClassAttributeHandler, "#{path}/class_attribute_handler"
  autoload :Box, "#{path}/box"
  autoload :Button, "#{path}/button"
end
