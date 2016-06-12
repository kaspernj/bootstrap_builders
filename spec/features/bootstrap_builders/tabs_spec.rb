require "rails_helper"

describe BootstrapBuilders::Tabs do
  it "renders tabs" do
    visit normal_tabs_bootstrap_builders_tabs_path

    expect(page).to have_http_status(:success)
    expect(current_path).to eq normal_tabs_bootstrap_builders_tabs_path
  end

  it "#set_default_first_active" do
    visit normal_tabs_bootstrap_builders_tabs_path

    li1 = find("a[href='#tab1']").find(:xpath, "..")
    container1 = find("#tab1")

    li2 = find("a[href='#tab2']").find(:xpath, "..")
    container2 = find("#tab2")

    expect(li1[:class]).to eq "active"
    expect(container1[:class]).to eq "tab-pane active"

    expect(li2[:class]).to eq nil
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
