require "spec_helper"

describe BootstrapHelpers::Button do
  include WorkingHelpers

  it "generates an edit button" do
    html = bs_edit_button(url: "/test/url")
    expect(html).to include "/test/url"
    expect(html).to include "edit"
    expect(html).to include "fa-wrench"
  end
end
