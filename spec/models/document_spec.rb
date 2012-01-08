require 'spec_helper'

describe Document do

	describe 'fields and validations' do
		it { should have_field(:uri).of_type(String) }
		it { should have_field(:title).of_type(String) }
		it { should have_field(:excerpt).of_type(String) }

		it { should validate_presence_of(:uri) }
		it { should validate_uniqueness_of(:uri).case_insensitive.with_message('already indexed') }
		it { should validate_presence_of(:title) }
		it { should validate_presence_of(:site)}
	end
	
	describe 'indexes' do
		it { Document.index_options[:title].should_not be nil  }
		it { Document.index_options[:uri][:unique].should be true }
	end

	describe 'search method' do
		before(:all) do
			10.times { Fabricate(:document) }
		end
		
		subject { Document }

		it { should respond_to :query }

		context "no parameter is passed" do
			it "should not fail" do 
				->{ Document.query }.should_not raise_error 
			end

			it "should return all documents" do
				Document.query.should eq Document.all
			end
		end

		context "when receiving site parameter" do
			before do
				@document = Document.last
			end

			describe "getting the document list" do

				# it "should find the site by its slug" do
				# 	Site.should_receive(:where).with(:slug => @document.site.slug).and_return(@document.site)
				# 	Document.query site: @document.site.slug

				# end

				it "should return a scope of this site's documents" do
					Document.query( site: @document.site.slug).all.should include(@document)
				end
			end

			it "should ignore null site argument" do
				Document.query( site: nil ).should include(@document)
			end

			it "should treat site_id as its synonimun"
		end

		context "when receiving string parameter" do
		  before(:all) do
		    @documents = []
		    5.times { @documents << Fabricate(:document) }
		  end

			it "should search on the document's title" do
				Document.query( string: @documents.first.title ).first.should == @documents.first
			end

			it "should not return non-matching values" do
				Document.query( string: @documents.first.title).each do |result|
					@documents.each do |document|
						document.should_not == result unless document == @documents.first
					end
				end
			end
		end

	end

	describe 'relationships with sites' do
		before :all do
			@url = "http://blog.cancaonova.com"
			@document = Fabricate.build(:document, uri: @url)
		end
		it { should be_referenced_in(:site).of_type(Site)}
		it { Document.index_options[:site_ids].should_not be nil }
		it "should pass the string to the Sites.parse_and_create method before saving" do
			Site.should_receive(:parse_and_create).with(@url)
			@document.site = @url
			@document.save
		end
		it "should be properly set to be the site provided on the string" do
			@document.save
			@document.site.uri.should eq "blog.cancaonova.com"
		end
	end
end
