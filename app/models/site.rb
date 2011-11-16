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
    
  before_save :generate_slug

  def self.parse_and_create(url)
  	url = URI.parse(url) rescue nil
    return nil unless url
  	unless site = Site.where( uri: url.host ).first
  		site = Site.create(name: url.host , uri: url.host)
  	end
  	site
  end

  private
  def generate_slug
      self.slug = URI.parse(self.uri).host
  end

end