require "rails_helper"

describe BootstrapBuilders::Flash do
  it "generates a flash" do
    visit generate_flash_bootstrap_builders_flashes_path

    flash = find(".bb-flash")

    expect(flash.text).to include "Success flash"
  end
end
