require 'spec_helper'
# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe DocumentsController do
  # This should return the minimal set of attributes required to create a valid
  # Document. As you add validations to Document, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    Fabricate.attributes_for :document
  end
  let(:site) {Fabricate(:site)}
  describe "GET index" do
    it "assigns all documents as @documents" do
      document = Document.create! valid_attributes
      get :index
      assigns(:documents).should include document
    end

    context "pagination" do
      before :all do
        Document.destroy_all
        @doclist = []  
        40.times { |i| @doclist << Document.create!(valid_attributes) }
      end

      it "should have 25 documents per page" do
        get :index
        assigns(:documents).options[:limit].should be 25
      end

      it "should get first page on the absence of page params" do
        get :index 
        assigns(:documents).options[:skip].should be 0
      end

      it "should respect the page param when it's set" do
        get :index, page: 2
        assigns(:documents).options[:skip].should be 25
      end
    end

    context "searching" do
      context "site-scoped" do
        it "should pass site id to searcher method" do
          doc = Fabricate(:document)
          get :index, site_id: doc.site.slug
          assigns(:documents).selector['site_id'].should == doc.site.id
        end
      end

      it "should assign string parameter when present (to a title search)" do
        get :index, string: 'test'
        assigns(:documents).selector[:title].should eq /test/i
      end
    end

  end

  describe "GET show" do
    it "assigns the requested document as @document" do
      document = Document.create! valid_attributes
      get :show, :id => document.id, :site_id => document.site.slug
      assigns(:document).should eq(document)
    end
  end

  describe "GET new" do
    it "assigns a new document as @document" do
      get :new
      assigns(:document).should be_a_new(Document)
    end
  end

  describe "GET edit" do
    it "assigns the requested document as @document" do
      document = Document.create! valid_attributes
      get :edit, :id => document.id, :site_id => document.site.slug
      assigns(:document).should eq(document)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Document" do
        expect {
          post :create, :document => valid_attributes
        }.to change(Document, :count).by(1)
      end

      it "assigns a newly created document as @document" do
        post :create, :document => valid_attributes
        assigns(:document).should be_a(Document)
        assigns(:document).should be_persisted
      end

      it "redirects to the created document" do
        post :create, :document => valid_attributes
        response.should redirect_to( site_document_url(Document.last.site.slug, Document.last.id) )
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved document as @document" do
        # Trigger the behavior that occurs when invalid params are submitted
        Document.any_instance.stub(:save).and_return(false)
        post :create, :document => {}
        assigns(:document).should be_a_new(Document)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Document.any_instance.stub(:save).and_return(false)
        post :create, :document => {}
        response.status.should eq 302
      end
    end

    describe "checking if document already exists" do

      context "document exists" do
        it "should redirect to update" do
          doc_params = valid_attributes and Document.create! doc_params
          Document.any_instance.should_receive(:update_attributes)
          post :create, document: doc_params
        end
      end

      it "should display the updated attributes" do
        doc_params = valid_attributes and Document.create! doc_params
        doc_params[:title] = 'a new title'
        post :create, document: doc_params
        assigns(:document).title.should == 'a new title'
      end

    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested document" do
        document = Document.create! valid_attributes
        # Assuming there are no other documents in the database, this
        # specifies that the Document created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Document.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => document.id, :document => {'these' => 'params'}, :site_id => site.slug
      end

      it "assigns the requested document as @document" do
        document = Document.create! valid_attributes
        put :update, :id => document.id, :document => valid_attributes, :site_id => site.slug
        assigns(:document).should eq(document)
      end

      it "redirects to the document" do
        document = Document.create! valid_attributes
        put :update, :id => document.id, :document => valid_attributes, :site_id => site.slug
        response.should redirect_to( site_document_url( Document.last.site.slug, Document.last.id ) )
      end
    end

    describe "with invalid params" do
      it "assigns the document as @document" do
        document = Document.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Document.any_instance.stub(:save).and_return(false)
        put :update, :id => document.id, :document => {}, :site_id => site.slug
        assigns(:document).should eq(document)
      end

      it "re-renders the 'edit' template" do
        document = Document.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Document.any_instance.stub(:save).and_return(false)
        put :update, :id => document.id, :document => {}, :site_id => site.slug
        response.status.should eq 302
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested document" do
      document = Document.create! valid_attributes
      expect {
        delete :destroy, :id => document.id, :site_id => site.slug
      }.to change(Document, :count).by(-1)
    end

    it "redirects to the documents list" do
      document = Document.create! valid_attributes
      delete :destroy, :id => document.id, :site_id => site.slug
      response.should redirect_to(documents_url)
    end
  end

end
