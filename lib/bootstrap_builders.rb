require "auto_autoloader"
require "html_gen"

class BootstrapBuilders
  path = "#{File.dirname(__FILE__)}/bootstrap_builders"

  autoload :ApplicationHelpers, "#{path}/application_helpers"
  autoload :Box, "#{path}/box"
  autoload :Button, "#{path}/button"
end
