require 'spec_helper'

describe "documents/index.html.haml" do
  before(:each) do
    Document.destroy_all and @docs = []
    30.times{ @docs << Fabricate(:document) }
    assign(:documents, Document.page())
  end

  it "renders a list of documents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @docs.first.title
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @docs.first.uri
  end

  it "renders paginations functions" do
    render
    rendered.should have_css("nav.pagination")
  end

  describe "search form" do
    render
    rendered.should have_css(".search input[type='text']")
  
end
