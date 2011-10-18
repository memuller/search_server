class Site
  include Mongoid::Document
  field :name, :type => String
  field :uri, :type => String
end
