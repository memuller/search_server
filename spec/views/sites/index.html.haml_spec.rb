require 'spec_helper'

describe "sites/index.html.haml" do
  before(:each) do
    assign(:sites, [
      Fabricate(:site), Fabricate(:site)
    ])
  end

  it "renders a list of sites" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr",  :count => 2 + 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    
  end
end
