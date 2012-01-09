require 'spec_helper'

describe "documents/index.html.haml" do
  before(:each) do
    Document.destroy_all and @docs = []
    30.times{ @docs << Fabricate(:document) }
    assign(:documents, Document.page())
  end

  describe "the documents list" do
    it "renders a list of documents" do
      render
      assert_select "tr",  :count => 25 + 1  
    end
    it "renders a link to the document" do
      render
      assert_select "tr>td>a[href=#{site_document_path(@docs.first.site.slug, @docs.first.id)}]", text: @docs.first.title
    end
    it "renders a link to the document url" do
      render
      assert_select "tr>td>a[href=#{@docs.first.uri}]", text: @docs.first.uri
    end
    it "renders a link to edit the document" do
      render
      assert_select "tr>td>a[href=#{edit_site_document_path(@docs.first.site.slug, @docs.first.id)}]", text: 'Edit'
    end
    it "renders a link to destroy the document" do
      render
      assert_select "tr>td>a[href=#{site_document_path(@docs.first.site.slug, @docs.first.id)}][data-method=delete]", text: 'Destroy'
    end
  end

  it "renders paginations functions" do
    render
    rendered.should have_css("nav.pagination")
  end

  it "renders a search form" do
    render
    rendered.should have_css(".search form input[type='text']#query")
    rendered.should have_css(".search form input[type='submit']")
  end
  
end
