class BootstrapBuilders::Configuration
  attr_accessor :default_table_classes

  def initialize
    @default_table_classes = ["table-bordered", "table-hover", "table-striped"]
  end
end
