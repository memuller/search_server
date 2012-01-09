require 'spec_helper'

describe "sites/index.html.haml" do
  before(:each) do
    @sites = [
      Fabricate(:site), Fabricate(:site)
    ]
    assign(:sites, @sites )
  end

  describe "fields that will be show" do
    it "will show URI" do
      render
      assert_select "th", count: 1, text: "Uri"
      assert_select "td", count: 1, text: @sites.first.uri
    end
    it "will show title" do
      render
      assert_select "th", count: 1, text: "Name"
      assert_select "td", count: 1, text: @sites.first.name
    end
  end

  it "renders a list of sites" do
    render
    assert_select "tr",  :count => 2 + 1  
  end

  it "shows a link to the site's documents" do
    render
    assert_select "a[href=#{site_documents_path(@sites.first.slug) }]", count: 1, text: 'Documents'  
  end

  describe "general links" do
    
    it "shows a link to create new sites" do
      render
      assert_select "a[href=#{new_site_path()}]", count: 1, text: 'New Site'
    end
  end
end
