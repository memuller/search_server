require 'spec_helper'

describe "documents/index.html.haml" do
  before(:each) do
    assign(:documents, [
      stub_model(Document,
        :title => "Title",
        :uri => "Uri"
      ),
      stub_model(Document,
        :title => "Title",
        :uri => "Uri"
      )
    ])
  end

  it "renders a list of documents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Uri".to_s, :count => 2
  end
end
