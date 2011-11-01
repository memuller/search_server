class Site
  include Mongoid::Document
  field :name, type: String
  field :uri, type: String
  field :slug, type: String

  has_many :documents, :dependent => :destroy

  index :name
  index :uri, unique: true
  index :slug, unique: true
  index :document_ids

  validates_presence_of :name
  validates :uri, presence: true, uniqueness: { case_sensitive: false, message: 'already here' }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  def self.parse_and_create(url)
  	url = URI.parse(url)
  	unless site = Site.where( uri: url.host ).first
  		site = Site.create(name: url.host , uri: url.host)
  	end
  	site
  end

end