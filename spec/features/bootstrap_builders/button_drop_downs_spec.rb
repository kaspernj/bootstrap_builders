require "rails_helper"

describe BootstrapBuilders::ButtonDropDown do
  describe "#show" do
    it "renders" do
      visit basic_bootstrap_builders_button_drop_downs_path

      test_item = find(".test-item-link")
      test_item_icon = find(".test-item-link i")

      expect(page).to have_http_status :success
      expect(current_path).to eq basic_bootstrap_builders_button_drop_downs_path
      expect(find("button").text).to eq "Test button drop down label"
      expect(test_item[:class]).to eq "test-item-link"
      expect(test_item["data-test-data-attribute"]).to eq "test_data_attribute_value"
      expect(test_item["data-confirm"]).to eq "Are you sure?"
      expect(test_item["data-method"]).to eq "post"
      expect(test_item[:href]).to eq "/test-item-url"
      expect(test_item_icon[:class]).to eq "fa fa-fw fa-edit"
    end
  end
end
