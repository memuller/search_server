require 'spec_helper'

describe "sites/show.html.haml" do
  before(:each) do
    @site = assign(:site, Fabricate(:site))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Uri/)
  end
end
