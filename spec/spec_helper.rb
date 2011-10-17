require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  
  ENV["RAILS_ENV"] ||= 'test'

  # does not load 
  require 'rails/mongoid'
  Spork.trap_class_method(Rails::Mongoid, :load_models)
  
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  require Rails.root.join('spec/support/mongoid.rb')

  RSpec.configure do |config|
    config.mock_with :rspec

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

  require Rails.root.join('spec/support/blueprints.rb')

  RSpec.configure do |config|
    config.before :all do
      Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
    end
  end
end