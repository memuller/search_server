class DocumentsController < ApplicationController
  respond_to :json, :html
  respond_to :js, :only => :index 
  
  # GET /documents
  # GET /documents.json
  def index
    @documents = params[:query] ? Document.where( :title => /#{params[:query]}/i) : Document
    @documents = @documents.page(params[:page])
    respond_with @documents
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    respond_with( @document = Document.find(params[:id]) )
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    respond_with( @document = Document.new )
  end

  # GET /documents/1/edit
  def edit
    respond_with( @document = Document.find(params[:id]) )
  end

  # POST /documents
  # POST /documents.json
  def create
    if(@document = Document.new(params[:document])).save
      flash['notice'] = 'Document was successfully created.'
      respond_with @document, 
        :location => site_document_url(@document.site.id.to_s , @document.id.to_s)
    else
      respond_with @document
    end
    
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    if (@document = Document.find(params[:id])).update_attributes(params[:document])
      flash['notice'] = 'Document was successfully updated.'
    end
    respond_with @document, 
        :location => site_document_url(@document.site.id.to_s , @document.id.to_s)
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    (@document = Document.find(params[:id])).destroy
    flash['notice'] = 'Destroyed document.'
    respond_with @document
  end
end
