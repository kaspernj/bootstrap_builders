require "rails_helper"

describe BootstrapBuilders::AttributeRows do
  let(:user) { create :user }

  it "generates rows in a table" do
    visit model_rows_bootstrap_builders_attribute_rows_path(user_id: user.id)

    expect(find(".bb-attributes-row-email .bb-attributes-row-title").text).to eq "Email"
    expect(find(".bb-attributes-row-email .bb-attributes-row-value").text).to eq user.email
  end
end
