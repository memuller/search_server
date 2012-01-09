require 'spec_helper'

describe Site do

	describe 'fields' do
		it { should have_field(:uri).of_type(String) }
		it { should have_field(:name).of_type(String) }
		it { should have_field(:slug).of_type(String) }
		it { should have_field(:description).of_type(String) }
	end
	describe 'validations' do
		it { should validate_presence_of(:uri) }
		it { should validate_uniqueness_of(:uri).case_insensitive.with_message('already here') }
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:slug) }
		it { should validate_uniqueness_of(:slug) }
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

	context "while generating slug" do
		it { Site.new.private_methods.should include :generate_slug }
		it { Site.new.private_methods.should include :assign_slug }
		
		it "happens before validations" do
			site = Fabricate.build(:site)
			site.slug.should be_nil
			site.valid?
			site.slug.should eq  URI.parse('http://' + site.uri).host.split('.').first
		end

		context "when slug is not set" do
			
			it "generates and assign a slug from site domain" do
				site = Fabricate(:site)
				site.slug.should eq URI.parse('http://' + site.uri).host.split('.').first
			end
			
			context "when slug already exists" do
				it "appends a number on its end" do
					site = Fabricate(:site)
					Fabricate(:site, slug: site.slug ,
						uri: site.uri + '/stuff/' ).slug.should == "#{site.slug}1"
				end
				it "increments numbers on its end" do
					sites = [Fabricate(:site)]
					2.times do |i|
						sites << Fabricate(:site, slug: sites.first.slug ,
							uri: sites.first.uri + "/stuff#{i}/" )
					end
					sites.last.slug.should == "#{sites.first.slug}2"
				end
			end
		end

		context "when slug is already set" do
			it "does not change it" do
				site = Fabricate(:site) and old_slug = site.slug
				site.update_attributes!(title: 'new title' )
				site.slug.should == old_slug
			end
				
		end
	end

		
	describe ".parse_and_create" do

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
		
		context "when checking for duplicates" do
			it "uses only the 'host' part of the URI" do
				Site.should_receive(:where).with({ uri: URI.parse(valid_url).host })
				Site.parse_and_create(valid_url)
			end
		end

		context "given an invalid url " do			
			it{ ->{ Site.parse_and_create(invalid_url) }.should_not raise_error }
			it{ Site.parse_and_create(invalid_url).should be nil }
		end
		
		context "given an url beloging to an already registered site" do
			it "returns it" do
				Site.parse_and_create(valid_url).should == Site.parse_and_create(valid_url)
			end
		end

		context "given a valid url" do
			it "creates and returns a site with proper URI" do
				response = Site.parse_and_create(valid_url)
				response.uri.should eq URI.parse(valid_url).host
			end
		end
	end
end
