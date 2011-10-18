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

	describe "relationships" do
		it {should reference_and_be_referenced_in_many(:documents).of_type(Document).with_dependent(:destroy)}
		it { Site.index_options[:document_ids].should_not be nil }
	end
end
