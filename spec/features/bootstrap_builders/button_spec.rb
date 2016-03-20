require "rails_helper"

describe BootstrapBuilders::Button do
  it "generates an edit button" do
    visit edit_btn_bootstrap_builders_buttons_path

    button = find(".bb-btn-edit")
    expect(button[:href]).to eq "/test_url"
    expect(button.text).to eq "Edit"

    icon = find(".bb-btn-edit i")
    expect(icon[:class]).to eq "fa fa-wrench"
  end
end
