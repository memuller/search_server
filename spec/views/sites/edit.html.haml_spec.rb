require 'spec_helper'

describe "sites/edit.html.haml" do
  before(:each) do
    @site = assign(:site, Fabricate(:site))
  end

  it "renders the edit site form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sites_path(@site), :method => "post" do
      assert_select "input#site_name", :name => "site[name]"
      assert_select "input#site_uri", :name => "site[uri]"
    end
  end
end
