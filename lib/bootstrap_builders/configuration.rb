class BootstrapBuilders::Configuration
  attr_accessor :default_table_classes

  def initialize
    @default_table_classes = [:bordered, :hover, :striped]
  end
end
