require 'spec_helper'

describe "sites/index.html.haml" do
  before(:each) do
    assign(:sites, [
      stub_model(Site,
        :name => "Name",
        :uri => "Uri"
      ),
      stub_model(Site,
        :name => "Name",
        :uri => "Uri"
      )
    ])
  end

  it "renders a list of sites" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Uri".to_s, :count => 2
  end
end
