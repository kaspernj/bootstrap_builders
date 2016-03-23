require "rails_helper"

describe BootstrapBuilders::Flash do
  it "generates a flash" do
    visit generate_flash_bootstrap_builders_flashes_path

    flash = find(".bb-flash")

    expect(flash.text).to include "Success flash"
    expect(flash[:class]).to include "alert-success"
  end

  it "allows for custom classes" do
    visit generate_flash_bootstrap_builders_flashes_path(class: "custom_class")

    flash = find(".bb-flash")
    flash_classes = flash[:class].split(/\s+/)

    expect(flash.text).to include "Success flash"
    expect(flash_classes).to include "custom_class"
  end
end
