require 'spec_helper'

describe Site do

	describe 'fields and validations' do
		it { should have_field(:uri).of_type(String) }
		it { should have_field(:name).of_type(String) }
		it { should have_field(:slug).of_type(String) }

		it { should validate_presence_of(:uri) }
		it { should validate_uniqueness_of(:uri).case_insensitive.with_message('already here') }
		it { should validate_presence_of(:name) }
		it { should validate_uniqueness_of(:slug).case_insensitive }
	end
	
	describe 'indexes' do
		it { Site.index_options[:name].should_not be nil  }
		it { Site.index_options[:uri][:unique].should be true }
		it { Site.index_options[:slug][:unique].should be true }
	end

	context "relationship with documents" do
		it {should reference_many(:documents).of_type(Document).with_dependent(:destroy)}
		it { Site.index_options[:document_ids].should_not be nil }
	end

	context "generating slug" do
		describe ""
	end


	context "parsing an URL into a site" do
		before :each do
			@full_url = "http://blog.cancaonova.com/"
			@url_with_subsite = "http://blog.cancaonova.com/revolucao"
			@host_only = "blog.cancaonova.com"
			Site.delete_all
		end 
		describe "parse_and_create class method" do
			subject {Site}
			it { should respond_to :parse_and_create }
			it { ->{Site.parse_and_create(@full_url)}.should_not raise_error ArgumentError }
			context "invalid url provided" do
				let(:invalid_url){"not_an_uri"}
				it{ ->{ Site.parse_and_create(invalid_url) }.should_not raise_error }
				it{ ->{ Site.parse_and_create(invalid_url) }.call }

			end
			it "creates a site with proper URI" do
				response = Site.parse_and_create(@full_url)
				response.uri.should eq @host_only
			end

		end
	end
end
