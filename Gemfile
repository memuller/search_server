source 'http://rubygems.org'

gem 'rails', '3.1.1'

# HAML
gem 'haml'
gem 'haml-rails'

# mongoid and bson_ext (mongo's C extensions, boosts performance)
gem 'mongoid'
gem 'bson_ext'

# kaminari paginator.
gem 'kaminari'

# server stuff
gem 'rack', '1.3.3'
gem 'thin'

group :test  do
	# Rspec etc
	gem 'rspec'
	gem 'rspec-rails'
	gem 'capybara'
	gem 'steak'
	gem 'autotest'
	gem 'mongoid-rspec' #rspec matchers. https://github.com/evansagge/mongoid-rspec

	# machinist for mongoid
	gem 'machinist', '>= 2.0.0.beta1'
	gem 'machinist_mongo', :git => 'https://github.com/nmerouze/machinist_mongo.git', 
		:branch => 'machinist2', :require => 'machinist/mongoid'
end

group :development, :test do
	gem 'ruby-debug19', :require => 'ruby-debug'
end 

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'