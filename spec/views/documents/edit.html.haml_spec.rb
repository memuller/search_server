require 'spec_helper'

describe "documents/edit.html.haml" do
# TODO: make this work somehow
=begin
before(:each) do
    @document = assign(:document, Fabricate(:document) )
  end

  it "renders the edit document form" do
    render @document.to_param + '/edit'
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => site_documents_path([@document.site,@document]), :method => "post" do
      assert_select "input#document_title", :name => "document[title]"
      assert_select "input#document_uri", :name => "document[uri]"
    end
  end
=end

end
