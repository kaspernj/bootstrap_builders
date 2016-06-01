require "rails_helper"

describe BootstrapBuilders::Tabs do
  it "renders tabs" do
    visit normal_tabs_bootstrap_builders_tabs_path

    expect(page).to have_http_status(:success)
    expect(current_path).to eq normal_tabs_bootstrap_builders_tabs_path
  end
end
