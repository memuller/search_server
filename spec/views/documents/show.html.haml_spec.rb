require 'spec_helper'

describe "documents/show.html.haml" do
  before(:each) do
    @document = assign(:document, Fabricate(:document) )
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/#{@document.title}/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/#{@document.uri}/)
  end
end
