require "spec_helper"

describe BootstrapBuilders::Panel do
  include WorkingHelpers

  it "generates a panel" do
    html = bb_panel("Test title", 300, right: "test") { "test" }
    expect(html).to include "test"
    expect(html).to include "Test title"
    expect(html).to include "width: 300px;"
  end

  it "generates a table" do
    html = bb_panel("Test title", table: true) { "trala" }
    expect(html).to include "<table "
  end
end
