require "rails_helper"

describe BootstrapBuilders::Panel do
  it "generates a panel" do
    visit panel_with_content_bootstrap_builders_panels_path

    table = find(".bb-panel")
    expect(table[:style]).to eq "width: 300;"

    title = find(".panel-title")
    expect(title.text).to eq "Test title"

    panel_body = find(".panel-body")
    expect(panel_body.text).to eq "Test"
  end

  it "generates a table" do
    visit panel_with_table_bootstrap_builders_panels_path

    title = find(".bb-panel .panel-title")
    expect(title.text).to eq "Test title"

    panel_table = find(".table-responsive table.table")
    expect(panel_table.text).to eq "Hello world"
  end
end
