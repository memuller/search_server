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
    rendered.should have_css(".search form input[type='text']#string")
    rendered.should have_css(".search form input[type='submit']")
  end
  
end

describe "documents/index.html.haml" do
  before(:all) do
    Document.delete_all and @site = Fabricate(:site) and @documents = []
    10.times do |i|
      @documents << Fabricate(:document, uri: "http://#{@site.uri}/#{i}" )
    end
    assign(:documents, Document.page())
    assign(:site, @site)
  end

  describe "site information box" do
      
    it "shows the site name (with url) as title" do
    render
      assert_select "h1>a[href=http://#{@site.uri}]", text: @site.name + "'s documents"
    end

    it "shows the site description" do
      render
      assert_select "p", text: @site.description
    end

    it "shows the number of documents under this site" do
      render 
      assert_select "div#document_count", text: @site.documents.size.to_s + " items"
    end

  end
end