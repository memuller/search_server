class Document
  include Mongoid::Document
  field :title, :type => String
  field :uri, :type => String
end
