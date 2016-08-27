require "rails_helper"

describe BootstrapBuilders::ProgressBar do
  it "renders progress bars" do
    visit normal_progress_bar_bootstrap_builders_progress_bars_path

    expect(page).to have_http_status(:success)
    expect(current_path).to eq normal_progress_bar_bootstrap_builders_progress_bars_path
    expect(page).to have_selector ".bb-progress-bar"
  end
end
