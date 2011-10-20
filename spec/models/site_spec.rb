require 'spec_helper'

describe Site do

	describe 'fields and validations' do
		it { should have_field(:uri).of_type(String) }
		it { should have_field(:name).of_type(String) }

		it { should validate_presence_of(:uri) }
		it { should validate_uniqueness_of(:uri).case_insensitive.with_message('already here') }
		it { should validate_presence_of(:name) }
	end
	
	describe 'indexes' do
		it { Site.index_options[:name].should_not be nil  }
		it { Site.index_options[:uri][:unique].should == true }
	end

	context "relationship with documents" do
		it {should reference_many(:documents).of_type(Document).with_dependent(:destroy)}
		it { Site.index_options[:document_ids].should_not be nil }
	end

	context "parsing an URL into sites" do
		before :each do
			@full_url = "http://blog.cancaonova.com/"
			@url_with_subsite = "http://blog.cancaonova.com/revolucao"
			@host_only = "blog.cancaonova.com"
			Site.destroy_all
		end 
		describe "its parse_and_create class method" do
			it "should exist, receiving an argument" do
				Site.should respond_to :parse_and_create
				->{Site.parse_and_create(@full_url)}.call.should_not raise_error ArgumentError
			end

			it "should a site object with the provided url" do
				response = Site.parse_and_create(@full_url)
				response.uri.should eq @host_only
			end

		end
	end
end
