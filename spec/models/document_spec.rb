require 'spec_helper'

describe Document do

	describe 'fields and validations' do
		it { should have_field(:uri).of_type(String) }
		it { should have_field(:title).of_type(String) }
		it { should have_field(:excerpt).of_type(String) }

		it { should validate_presence_of(:uri) }
		it { should validate_uniqueness_of(:uri).case_insensitive.with_message('already indexed') }
		it { should validate_presence_of(:title) }
	end
	
	describe 'indexes' do
		it { Document.index_options[:title].should_not be_nil  }
		it { Document.index_options[:uri][:unique].should == true }
	end
end
