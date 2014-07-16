require 'spec_helper'

describe "sales_aids/new" do
  before(:each) do
    assign(:sales_aid, stub_model(SalesAid).as_new_record)
  end

  it "renders new sales_aid form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sales_aids_path, "post" do
    end
  end
end
