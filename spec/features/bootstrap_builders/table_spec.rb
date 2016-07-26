require "rails_helper"

describe BootstrapBuilders::Table do
  it "outputs a normal table" do
    visit normal_table_bootstrap_builders_tables_path

    table = find(".bb-table")
    classes = table[:class].split(/\s+/)
    td = find(".bb-table tbody tr td")

    expect(classes).to eq ["table-bordered", "table-hover", "table-striped", "table", "bb-table"]
    expect(td.text).to eq "Hello world"
  end

  it "outputs a resposive table" do
    visit responsive_table_bootstrap_builders_tables_path

    wrapper = find(".table-responsive")
    classes = wrapper[:class].split(/\s+/)
    expect(classes).to eq ["table-responsive"]
    expect(wrapper.text).to eq "Hello world"
  end

  it "allows custom classes" do
    visit custom_classes_bootstrap_builders_tables_path

    table = find(".bb-table")
    classes = table[:class].split(/\s+/)
    td = find(".bb-table tbody tr td")

    expect(classes).to eq ["table-striped", "table", "bb-table"]
    expect(td.text).to eq "Hello world"
  end

  it "allows classes through config" do
    old_classes = BootstrapBuilders.configuration.default_table_classes

    begin
      BootstrapBuilders.configuration.default_table_classes = [:bordered]

      visit normal_table_bootstrap_builders_tables_path

      table = find(".bb-table")
      classes = table[:class].split(/\s+/)
      td = find(".bb-table tbody tr td")

      expect(classes).to eq ["table-bordered", "table", "bb-table"]
      expect(td.text).to eq "Hello world"
    ensure
      BootstrapBuilders.configuration.default_table_classes = old_classes
    end
  end
end
