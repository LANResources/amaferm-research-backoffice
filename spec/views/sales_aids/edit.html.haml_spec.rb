require 'spec_helper'

describe "sales_aids/edit" do
  before(:each) do
    @sales_aid = assign(:sales_aid, stub_model(SalesAid))
  end

  it "renders the edit sales_aid form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sales_aid_path(@sales_aid), "post" do
    end
  end
end
