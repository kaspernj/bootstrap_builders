require "rails_helper"

describe "date picker inputs" do
  describe "#bb_date_picker_input" do
    it "renders the input" do
      visit date_picker_input_bootstrap_builders_date_picker_inputs_path

      expect(page).to have_http_status :success
      expect(current_path).to eq date_picker_input_bootstrap_builders_date_picker_inputs_path
    end
  end

  describe "#bb_date_time_picker_input" do
    it "renders the input" do
      visit date_time_picker_input_bootstrap_builders_date_picker_inputs_path

      expect(page).to have_http_status :success
      expect(current_path).to eq date_time_picker_input_bootstrap_builders_date_picker_inputs_path
    end
  end
end
