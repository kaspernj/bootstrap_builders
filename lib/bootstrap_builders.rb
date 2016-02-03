require "html_gen"

class BootstrapBuilders
  path = "#{File.dirname(__FILE__)}/bootstrap_builders"

  autoload :ApplicationHelper, "#{path}/application_helper"
  autoload :AttributeRows, "#{path}/attribute_rows"
  autoload :ClassAttributeHandler, "#{path}/class_attribute_handler"
  autoload :IsAChecker, "#{path}/is_a_checker"
  autoload :Box, "#{path}/box"
  autoload :Button, "#{path}/button"
end
