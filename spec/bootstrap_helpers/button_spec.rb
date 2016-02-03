require "spec_helper"

describe BootstrapBuilders::Button do
  include WorkingHelpers

  it "generates an edit button" do
    html = bs_edit_btn(url: "/test/url")
    expect(html).to include "/test/url"
    expect(html).to include "edit"
    expect(html).to include "fa fa-wrench"
  end
end
