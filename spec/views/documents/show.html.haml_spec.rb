require 'spec_helper'

describe "documents/show.html.haml" do
  before(:each) do
    @document = assign(:document, stub_model(Document,
      :title => "Title",
      :uri => "Uri"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Uri/)
  end
end
