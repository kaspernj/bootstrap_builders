require "spec_helper"

describe BootstrapBuilders::Box do
  include WorkingHelpers

  it "generates a box by using panels" do
    html = bs_box("Test title", 300, right: "test") { "test" }
    expect(html).to include "test"
    expect(html).to include "Test title"
    expect(html).to include "width: 300px;"
  end

  it "generates a table" do
    html = bs_box("Test title", table: true) { "trala" }
    expect(html).to include "<table "
  end
end
