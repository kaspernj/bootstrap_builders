require "rails_helper"

describe BootstrapBuilders::Tabs do
  it "renders tabs" do
    visit normal_tabs_bootstrap_builders_tabs_path

    expect(page).to have_http_status(:success)
    expect(current_path).to eq normal_tabs_bootstrap_builders_tabs_path
  end

  it "selects the given tab by query parameters" do
    visit normal_tabs_bootstrap_builders_tabs_path(bb_selected_tab: "tab2")

    tab2 = find("#tab2")
    expect(tab2[:class]).to eq "tab-pane active"
  end

  it "#set_default_first_active" do
    visit normal_tabs_bootstrap_builders_tabs_path

    link1 = find("a[href='#tab1']")
    container1 = find("#tab1")

    link2 = find("a[href='#tab2']")
    container2 = find("#tab2")

    expect(link1[:class]).to include "active"
    expect(link1[:class]).to include "show"
    expect(container1[:class]).to eq "tab-pane active"

    expect(link2[:class]).to eq "nav-link"
    expect(container2[:class]).to eq "tab-pane"
  end

  describe "pills" do
    it "sets the correct classes with help from argument parser" do
      visit pills_bootstrap_builders_tabs_path

      nav = find(".bb-tabs-container > .nav")

      expect(nav[:class]).to eq "nav nav-pills"
    end
  end
end
