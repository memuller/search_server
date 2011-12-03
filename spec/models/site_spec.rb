require 'spec_helper'

describe Site do

	describe 'fields' do
		it { should have_field(:uri).of_type(String) }
		it { should have_field(:name).of_type(String) }
		it { should have_field(:slug).of_type(String) }
	end
	describe 'validations' do
		it { should validate_presence_of(:uri) }
		it { should validate_uniqueness_of(:uri).case_insensitive.with_message('already here') }
		it { should validate_presence_of(:name) }
	end
	
	describe 'indexes' do
		subject { Site.index_options }
		its ([:name]) { should_not be nil }
		its ([:uri]) { should eq unique: true }
		its ([:slug]) { should eq unique: true }
	end

	context "relationship with documents" do
		it {should reference_many(:documents).of_type(Document).with_dependent(:destroy)}
		it { Site.index_options[:document_ids].should_not be nil }
	end

	context "generating slug" do
		describe "generate_slug method" do
			it { Site.new.private_methods.should include :generate_slug }
			it "should generate a slug from site domain" do
				site = Fabricate(:site)
				site.slug.should eq URI.parse(site.uri).host
			end
			
		end
	end

		
	describe "parse_and_create class method" do

		before(:each) { Site.delete_all }

		let(:valid_url) { "http://cancaonova.com" }
		let(:valid_document_urls) { [
				"http://blog.cancaonova.com/one",
				"http://blog.cancaonova.com/two",
				"http://blog.cancaonova.com/three"
			] }
		let(:invalid_url) { "not an uri" } 
		subject { Site }
		
		it { should respond_to :parse_and_create }
		it { Site.method(:parse_and_create).parameters.size.should be 1 }
		
		describe "ignoring protocol and sub-uri" do
			it "should use only the host when checking for duplicates" do
				Site.should_receive(:where).with({ uri: URI.parse(valid_url).host })
				Site.parse_and_create(valid_url)
			end
		end

		context "invalid url provided" do			
			it{ ->{ Site.parse_and_create(invalid_url) }.should_not raise_error }
			it{ Site.parse_and_create(invalid_url).should be nil }
		end
		
		context "site with the url already exists" do
			it "returns it" do
				Site.parse_and_create(valid_url).should == Site.parse_and_create(valid_url)
			end
		end
		
		context "url is valid and untaken" do
			it "creates and returns a site with proper URI" do
				response = Site.parse_and_create(valid_url)
				response.uri.should eq URI.parse(valid_url).host
			end
		end
	end
end
