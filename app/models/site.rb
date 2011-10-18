class Site
  include Mongoid::Document
  field :name, :type => String
  field :uri, :type => String

  has_and_belongs_to_many :documents, :dependent => :destroy

  index :name
  index :uri, :unique => true
  index :document_ids

  validates_presence_of :name
  validates :uri, presence: true, uniqueness: { case_sensitive: false, message: 'already here' }

end