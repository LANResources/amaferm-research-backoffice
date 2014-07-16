require 'spec_helper'

describe "sales_aids/show" do
  before(:each) do
    @sales_aid = assign(:sales_aid, stub_model(SalesAid))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
