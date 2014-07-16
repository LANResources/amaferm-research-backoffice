require 'spec_helper'

describe "sales_aids/index" do
  before(:each) do
    assign(:sales_aids, [
      stub_model(SalesAid),
      stub_model(SalesAid)
    ])
  end

  it "renders a list of sales_aids" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
